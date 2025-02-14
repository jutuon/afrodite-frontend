
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

Widget showReportAction(BuildContext context, ProfileEntry profile) {
  return MenuItemButton(
    onPressed: () {
      MyNavigator.push(context, MaterialPage<void>(child: ReportScreen(
        profile: profile,
      )));
    },
    child: Text(context.strings.report_screen_title),
  );
}

class ReportScreen extends StatefulWidget {
  final ProfileEntry profile;
  const ReportScreen({
    required this.profile,
    super.key,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final api = LoginRepository.getInstance().repositories.api;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.report_screen_title),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final settings = reportList(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...settings,
        ],
      ),
    );
  }

  List<Widget> reportList(BuildContext context) {
    List<Widget> settings = [];

    if (widget.profile.profileText.isNotEmpty) {
      settings.add(reportListTile(context.strings.report_screen_action_profile_text, () async {
        final r = await showConfirmDialog(
          context,
          context.strings.report_screen_dialog_profile_text_title,
          details: widget.profile.profileTextOrFirstCharacterProfileText(false),
          yesNoActions: true,
          scrollable: true,
        );
        if (context.mounted && r == true) {
          final result = await api.profile((api) => api.postProfileReport(UpdateProfileReport(
            content: ProfileReportContent(profileText: widget.profile.profileText),
            target: widget.profile.uuid,
          ))).ok();

          if (result == null) {
            showSnackBar(R.strings.generic_error_occurred);
          } else if (result.errorOutdatedReportContent) {
            showSnackBar(R.strings.report_screen_snackbar_profile_text_has_changed);
          } else {
            showSnackBar(R.strings.report_screen_snackbar_report_successful);
          }
        }
      }));
    }

    return settings;
  }

  Widget reportListTile(String text, void Function() action) {
    return ListTile(
      onTap: action,
      title: Text(text),
    );
  }
}
