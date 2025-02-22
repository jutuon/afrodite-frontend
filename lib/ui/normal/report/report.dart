
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/report/report_profile_image.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

Widget showReportAction(BuildContext context, ProfileEntry profile) {
  return MenuItemButton(
    onPressed: () async {
      final chat = LoginRepository.getInstance().repositories.chat;
      final isMatch = await chat.isInMatches(profile.uuid);
      if (!context.mounted) {
        return;
      }
      await MyNavigator.push(context, MaterialPage<void>(child: ReportScreen(
        profile: profile,
        isMatch: isMatch,
      )));
    },
    child: Text(context.strings.report_screen_title),
  );
}

class ReportScreen extends StatefulWidget {
  final ProfileEntry profile;
  final bool isMatch;
  const ReportScreen({
    required this.profile,
    required this.isMatch,
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

    if (widget.profile.name.isNotEmpty) {
      settings.add(reportListTile(context.strings.report_screen_profile_name_action, () async {
        final r = await showConfirmDialog(
          context,
          context.strings.report_screen_profile_name_dialog_title,
          details: widget.profile.profileNameOrFirstCharacterProfileName(),
          yesNoActions: true,
          scrollable: true,
        );
        if (context.mounted && r == true) {
          final result = await api.profile((api) => api.postReportProfileName(UpdateProfileNameReport(
            target: widget.profile.uuid,
            profileName: widget.profile.name,
          ))).ok();

          if (result == null) {
            showSnackBar(R.strings.generic_error_occurred);
          } else if (result.errorOutdatedReportContent) {
            showSnackBar(R.strings.report_screen_profile_name_changed_error);
          } else if (result.errorTooManyReports) {
            showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
          } else {
            showSnackBar(R.strings.report_screen_snackbar_report_successful);
          }
        }
      }));
    }

    if (widget.profile.profileText.isNotEmpty) {
      settings.add(reportListTile(context.strings.report_screen_profile_text_action, () async {
        final r = await showConfirmDialog(
          context,
          context.strings.report_screen_profile_text_dialog_title,
          details: widget.profile.profileTextOrFirstCharacterProfileText(false),
          yesNoActions: true,
          scrollable: true,
        );
        if (context.mounted && r == true) {
          final result = await api.profile((api) => api.postReportProfileText(UpdateProfileTextReport(
            target: widget.profile.uuid,
            profileText: widget.profile.profileText,
          ))).ok();

          if (result == null) {
            showSnackBar(R.strings.generic_error_occurred);
          } else if (result.errorOutdatedReportContent) {
            showSnackBar(R.strings.report_screen_profile_text_changed_error);
          } else if (result.errorTooManyReports) {
            showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
          } else {
            showSnackBar(R.strings.report_screen_snackbar_report_successful);
          }
        }
      }));
    }

    final acceptedContent = widget.profile.content.where((v) => v.accepted);
    if (acceptedContent.isNotEmpty) {
      settings.add(reportListTile(context.strings.report_screen_profile_image_action, () {
        MyNavigator.push(context, MaterialPage<void>(child: ReportProfileImageScreen(
          profileEntry: widget.profile,
          isMatch: widget.isMatch,
        )));
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
