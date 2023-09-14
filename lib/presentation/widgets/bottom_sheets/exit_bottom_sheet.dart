import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speak_up/data/providers/app_navigator_provider.dart';
import 'package:speak_up/presentation/widgets/buttons/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showExitBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const ExitBottomSheet();
      });
}

class ExitBottomSheet extends ConsumerWidget {
  const ExitBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          child: Column(children: [
            const SizedBox(
              height: 32,
            ),
            Text(AppLocalizations.of(context)!.areYouSure,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                text: AppLocalizations.of(context)!.exit,
                fontWeight: FontWeight.bold,
                textSize: 16,
                marginVertical: 16,
                onTap: () {
                  Navigator.of(context).pop();
                  ref.read(appNavigatorProvider).pop();
                }),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 32,
            ),
          ]),
        ),
      ],
    );
  }
}