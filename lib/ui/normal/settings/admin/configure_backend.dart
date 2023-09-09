

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';



class ConfigureBackendPage extends StatefulWidget {
  const ConfigureBackendPage({Key? key}) : super(key: key);

  @override
  _ConfigureBackendPageState createState() => _ConfigureBackendPageState();
}

class _ConfigureBackendPageState extends State<ConfigureBackendPage> {

  final Server _selectedServer = Server.account;
  int _userBots = 0;
  int _adminBots = 0;
  TextEditingController _userBotsController = TextEditingController(text: "0");
  TextEditingController _adminBotsController = TextEditingController(text: "0");
  var _configFormKey = GlobalKey<FormState>();
  CurrentConfig? _currentConfig;

  @override
  void initState() {
    super.initState();
  }

  void updateStateWithData(CurrentConfig? data) {
    _adminBots = data?.config.bots?.admins ?? 0;
    _adminBotsController.text = _adminBots.toString();
    _userBots = data?.config.bots?.users ?? 0;
    _userBotsController.text = _userBots.toString();
    _currentConfig = data;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (ApiManager.getInstance().inMicroserviceMode()) {
      actions = [];
    } else {
      actions = [];
    }
    actions.add(IconButton(onPressed: () async {
        final data = await getData(_selectedServer);
        setState(() {
          updateStateWithData(data);
        });
    }, icon: const Icon(Icons.refresh)));

    Widget body = showConfigScreen(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Configure backend: ${_selectedServer.name}"),
        actions: actions,
      ),
      body: body,
    );
  }

  Widget showConfigScreen(BuildContext context) {
    final currentConfig = _currentConfig;
    if (currentConfig == null) {
      return FutureBuilder(
        future: getData(_selectedServer),
        initialData: null,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active || ConnectionState.waiting: {
              return buildProgressIndicator();
            }
            case ConnectionState.none || ConnectionState.done: {
              final data = snapshot.data;
              if (data != null) {
                updateStateWithData(data);
              }
              return showContent(context);
            }
          }
        });
    } else {
      return showContent(context);
    }
  }

  Widget showContent(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountData>(
      builder: (context, state) {
        final Widget currentConfig;
        if (state.capabilities.adminServerMaintentanceViewBackendSettings ?? false) {
          currentConfig = showBackendConfiguration();
        } else {
          currentConfig = const Text("No capability for viewing backend configuration");
        }

        final Widget rebootAction;
        if (state.capabilities.adminServerMaintentanceRebootBackend ?? false) {
          rebootAction = displayRestart(context);
        } else {
          rebootAction = const Text("No capability for rebooting backend");
        }

        final Widget resetAction;
        if ((state.capabilities.adminServerMaintentanceRebootBackend ?? false) &&
            (state.capabilities.adminServerMaintentanceResetData ?? false)) {
          resetAction = displayReset(context);
        } else {
          resetAction = const Text("No capability for resetting backend");
        }

        final Widget configureBackend;
        if (state.capabilities.adminServerMaintentanceSaveBackendSettings ?? false) {
          configureBackend = displaySaveConfig(context);
        } else {
          configureBackend = const Text("No capability for saving backend config");
        }

        final widgets = [
          currentConfig,
          configureBackend,
          rebootAction,
          resetAction,
        ];

        final paddedWidgets = <Widget>[];
        for (final widget in widgets) {
          paddedWidgets.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ));
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paddedWidgets,
          ),
        );
      }
    );
  }

  Widget showBackendConfiguration() {
    final currentConfig = _currentConfig;
    if (currentConfig == null) {
      return Text(currentConfig.toString());
    } else {
      return Text(currentConfig.config.toString());
    }
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget displayRestart(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();

        showConfirmDialog(context, "Restart backend?")
          .then((value) async {
            if (value == true) {
              final result = await ApiManager.getInstance()
                .commonAdmin(
                  _selectedServer, (api) async {
                    await api.postRequestRestartOrResetBackend(false);
                    return true;
                  }
                );
              if (result != null) {
                showSnackBar("Restart requested!");
              } else {
                showSnackBar("Restart request failed!");
              }
            }
          });
      },
      child: const Text("Restart backend"),
    );
  }

  Widget displayReset(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
      FocusScope.of(context).unfocus();

      showConfirmDialog(context, "Reset backend?", details: "Data loss warning! This can remove data, if done more than once.")
          .then((value) async {
            if (value == true) {
              final result = await ApiManager.getInstance()
                .commonAdmin(
                  _selectedServer, (api) async {
                    await api.postRequestRestartOrResetBackend(true);
                    return true;
                  }
                );
              if (result != null) {
                showSnackBar("Reset requested!");
              } else {
                showSnackBar("Reset request failed!");
              }
            }
          });
      },
      child: const Text("Reset backend"),
    );
  }

  Widget displaySaveConfig(BuildContext context) {
    const text = Text("Bots");

    final adminBots = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Admin bots',
      ),
      validator: (value) {
        final number = int.tryParse(value ?? "");
        if (number == null) {
          return "Not a number";
        }
        return null;
      },
      onChanged: (value) {
        final number = int.tryParse(value);
        if (number != null) {
          setState(() {
            _adminBots = number;
          });
        }
      },
      controller: _adminBotsController,
    );

    final userBots = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'User bots',
      ),
      validator: (value) {
        final number = int.tryParse(value ?? "");
        if (number == null) {
          return "Not a number";
        }
        return null;
      },
      onChanged: (value) {
        final number = int.tryParse(value);
        if (number != null) {
          setState(() {
            _userBots = number;
          });
        }
      },
      controller: _userBotsController,
    );

    final form = Form(
      key: _configFormKey,
      child: Column(
        children: [
          adminBots,
          const Padding(padding: EdgeInsets.all(8.0)),
          userBots,
        ],
      ),
    );

    final button = ElevatedButton(
      onPressed: () {
        if (_configFormKey.currentState?.validate() == false) {
          return;
        }

        FocusScope.of(context).unfocus();

        final bots = BotConfig(admins: _adminBots, users: _userBots);
        final config = BackendConfig(bots: bots);
        showConfirmDialog(context, "Save backend config?", details: "New config: ${config.toString()}")
          .then((value) async {
            if (value == true) {

              final result = await ApiManager.getInstance()
                .commonAdmin(
                  _selectedServer, (api) async {
                    await api.postBackendConfig(config);
                    return true;
                  }
                );
              if (result != null) {
                showSnackBar("Config saved!");
              } else {
                showSnackBar("Config save failed!");
              }
            }
          });
      },
      child: const Text("Save backend config"),
    );

    final widgets = [
      text,
      form,
      button,
    ];

    final paddedWidgets = <Widget>[];
    for (final widget in widgets) {
      paddedWidgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget,
      ));
    }


    return Column(
      children: paddedWidgets,
    );
  }
}

Future<CurrentConfig?> getData(Server server) async {
  final config = await ApiManager.getInstance().commonAdmin(server, (api) => api.getBackendConfig());
  if (config == null) {
    return null;
  }

  return CurrentConfig(config);
}

class CurrentConfig {
  final BackendConfig config;

  CurrentConfig(
    this.config,
  );
}
