import "package:flutter/material.dart";
import "package:photos/theme/ente_theme.dart";
import "package:photos/ui/common/loading_widget.dart";
import 'package:photos/ui/components/buttons/icon_button_widget.dart';

///https://www.figma.com/file/SYtMyLBs5SAOkTbfMMzhqt/ente-Visual-Design?node-id=8113-59605&t=OMX5f5KdDJYWSQQN-4
class InfoItemWidget extends StatelessWidget {
  final IconData leadingIcon;
  final VoidCallback? editOnTap;
  final String title;
  final Future<List<Widget>> subtitleSection;
  final bool hasChipButtons;
  const InfoItemWidget({
    required this.leadingIcon,
    this.editOnTap,
    required this.title,
    required this.subtitleSection,
    this.hasChipButtons = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("InfoItemWidget.build -------");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButtonWidget(
                icon: leadingIcon,
                iconButtonType: IconButtonType.secondary,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 3.5, 16, 3.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: hasChipButtons
                            ? getEnteTextTheme(context).smallMuted
                            : getEnteTextTheme(context).body,
                      ),
                      SizedBox(height: hasChipButtons ? 8 : 4),
                      Flexible(
                        child: FutureBuilder(
                          future: subtitleSection,
                          builder: (context, snapshot) {
                            Widget child;
                            if (snapshot.hasData) {
                              final subtitle = snapshot.data as List<Widget>;
                              if (subtitle.isNotEmpty) {
                                child = Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: subtitle,
                                );
                              } else {
                                child = const SizedBox.shrink();
                              }
                            } else {
                              child = EnteLoadingWidget(
                                padding: 3,
                                size: 11,
                                color: getEnteColorScheme(context).strokeMuted,
                                alignment: Alignment.centerLeft,
                              );
                            }
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              switchInCurve: Curves.easeInOutExpo,
                              child: child,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        editOnTap != null
            ? IconButtonWidget(
                icon: Icons.edit,
                iconButtonType: IconButtonType.secondary,
                onTap: editOnTap,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
