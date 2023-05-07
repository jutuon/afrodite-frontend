import "dart:ffi";
import "dart:io";

import "package:camera/camera.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/camera_page.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";

import "package:flutter/scheduler.dart";

// TODO: save initial setup values, so that it will be possible to restore state
//       if system kills the app when selecting profile photo

class InitialSetupPage extends RootPage {
  const InitialSetupPage({Key? key}) : super(MainState.initialSetup, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setup your new account")),
        body: InitialSetupWidget(),
      );
  }
}

class InitialSetupWidget extends StatefulWidget {
  const InitialSetupWidget({super.key});

  @override
  State<InitialSetupWidget> createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> {
  final _accountFormKey = GlobalKey<FormState>();
  final _profileFormKey = GlobalKey<FormState>();
  int _currentStep = 3;

  @override
  Widget build(BuildContext context) {
    final steps = createSteps();
    void Function()? onStepCancelHandler;
    if (_currentStep == 0) {
      onStepCancelHandler = null;
    } else {
      onStepCancelHandler = () {
        if (_currentStep > 0) {
          setState(() {
            updateStep(_currentStep - 1);
          });
        }
      };
    }

    onStepContinueHandler() {
      if (_currentStep < steps.length - 1) {
        setState(() {
          updateStep(_currentStep + 1);
        });
      }
    }
    void Function()? onStepContinue;
    if (_currentStep == 0) {
      onStepContinue = () {
        var valid = _accountFormKey.currentState?.validate() ?? false;
        if (valid) {
          _accountFormKey.currentState?.save();
          onStepContinueHandler();
        }
      };
    } else if (_currentStep == 1) {
      onStepContinue = () {
        var valid = _profileFormKey.currentState?.validate() ?? false;
        if (valid) {
          _profileFormKey.currentState?.save();
          onStepContinueHandler();
        }
      };
    } else if (_currentStep == 2) {
      onStepContinue = () {
        if (context.read<InitialSetupBloc>().state.securitySelfie != null) {
          onStepContinueHandler();
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No image. Take one using the camera button."), behavior: SnackBarBehavior.floating)
          );
        }
      };
    } else if (_currentStep == 3) {
      onStepContinue = () {
        // if (context.read<InitialSetupBloc>().state.securitySelfie != null) {
        //   onStepContinueHandler();
        // } else {
        //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("No image. Take one using the camera button."), behavior: SnackBarBehavior.floating)
        //   );
        // }
      };
    } else {
      onStepContinue = onStepContinueHandler;
    }


    return Stepper(
      currentStep: _currentStep,
      onStepCancel: onStepCancelHandler,
      onStepContinue: onStepContinue,
      onStepTapped: (i) {
        if (i < steps.length && (i < _currentStep)) {
          setState(() {
            updateStep(i);
          });
        }
      },
      controlsBuilder: (context, details) {
        var buttonContinue = ElevatedButton(
          child: const Text("CONTINUE"),
          onPressed: details.onStepContinue,
        );
        var buttonBack = MaterialButton(
          child: const Text("BACK"),
          onPressed: details.onStepCancel,
        );
        Widget buttons = Row(children: [buttonContinue, const Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)), buttonBack]);
        return Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0), child: buttons);
      },
      steps: steps,
    );
  }

  void updateStep(int i) {
    _currentStep = i;
  }

  List<Step> createSteps() {
    final counter = Counter();

    //timeDilation = 10.0;
    return [
        createAccountStep(counter.next()),
        createProfileStep(counter.next()),
        createTakeSelfieStep(counter.next()),
        createSelectProfileImageStep(counter.next()),
      ];
  }

  Step createAccountStep(int id) {
    final accountForm = Form(
      key: _accountFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: "Email",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
        onSaved: (newValue) => context.read<InitialSetupBloc>().add(SetEmail(newValue ?? "")),
      ),
    );

    return Step(
      title: const Text("Account"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: accountForm,
      ),
    );
  }

  Step createProfileStep(int id) {
    final profileForm = Form(
      key: _profileFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: "First name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
        onSaved: (newValue) => context.read<InitialSetupBloc>().add(SetProfileName(newValue ?? "")),
      ),
    );
    return Step(
      title: const Text("Profile"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: profileForm,
      )
    );
  }

  Step createTakeSelfieStep(int id) {
    return Step(
      title: const Text("Take security selfie"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Column(
        children: [
          const Text("Take image in which your face is clearly visible."),
          Row(children: [
            const Icon(Icons.person, size: 150.0, color: Colors.black45),
            BlocBuilder<InitialSetupBloc, InitialSetupData>(builder: (context, state) {
              Widget cameraButton = ElevatedButton.icon(label: Text("Camera"), icon: Icon(Icons.camera_alt), onPressed: () async {
                var _ = await Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (_) {
                      CameraPage camera = CameraPage(ImageType.securitySelfie);
                      return camera;
                    }),
                );
                setState(() {
                  // Update to display current image
                });
              });
              List<Widget> selfieImageWidgets = [cameraButton];
              XFile? securitySelfie = state.securitySelfie;
              if (securitySelfie != null) {
                selfieImageWidgets = [Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.file(File(securitySelfie.path), height: 200,),
                ), cameraButton];
              }
              return Column(
                children: selfieImageWidgets
              );
            },)
          ]),
        ],
      )
    );
  }

  Step createSelectProfileImageStep(int id) {

    Widget image = FutureBuilder<LostDataResponse>(
      future: ImagePicker().retrieveLostData(),
      builder: (BuildContext context, AsyncSnapshot<LostDataResponse> lostData) {
        return BlocBuilder<InitialSetupBloc, InitialSetupData>(builder: (context, state) {
          final initialSetupBloc = context.read<InitialSetupBloc>();
            Widget selectImageButton = ElevatedButton.icon(
              label: Text("Select image"),
              icon: Icon(Icons.image),
              onPressed: () async {
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  print(image.path);
                  initialSetupBloc.add(SetProfileImage(image));
                  setState(() {
                    // Update to display current image
                  });
                }
              }
            );
            List<Widget> imageWidgets = [selectImageButton];
            XFile? profileImage = state.profileImage;
            var lostImageSelection = lostData.data?.file;
            if (profileImage == null && lostImageSelection != null) {
              profileImage = lostImageSelection;
            }

            if (profileImage != null) {
              imageWidgets = [Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.file(File(profileImage.path), height: 200,),
              ), selectImageButton];
            }
            return Column(
              children: imageWidgets
            );
          });
      }
    );

    return Step(
      title: const Text("Select proifle image"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Column(children: [
        const Text("Select profile image"),
        image,
      ]),
    );
  }
}

class Counter {
  int value = 0;

  Widget? onlyIfSelected(int i, Widget w) {
    if (value == i) {
      return w;
    } else {
      return null;
    }
  }

  int next() {
    var current = value;
    value += 1;
    return current;
  }
}
