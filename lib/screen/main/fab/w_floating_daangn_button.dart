import 'package:fast_app_base/common/cli_common.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/fab/floating_small_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final floatingExpandedProvider = StateProvider((ref) {
  return false;
});

class FloatingDaangnButton extends ConsumerStatefulWidget {
  const FloatingDaangnButton({super.key});

  @override
  ConsumerState<FloatingDaangnButton> createState() => _FloatingDaangnButtonState();
}

class _FloatingDaangnButtonState extends ConsumerState<FloatingDaangnButton> {
  @override
  Widget build(BuildContext context) {
    final isExpanded = ref.watch(floatingExpandedProvider);
    final isSmall = ref.watch(isFloatingButtonSmallProvider);
    return Stack(
      children: [
        Positioned.fill(
            child: IgnorePointer(
          ignoring: !isExpanded,
          child: AnimatedContainer(
            duration: 300.ms,
            color: isExpanded ? Colors.black.withOpacity(0.3) : Colors.transparent,
          ),
        )),
        Align(
          alignment: Alignment.bottomRight,
          child: Tap(
            onTap: () {
              ref.read(floatingExpandedProvider.notifier).state = !isExpanded;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: isExpanded ? 1 : 0,
                  duration: 100.ms,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 160,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(right: 15, bottom: 10),
                        decoration: BoxDecoration(
                            color: context.appColors.floatingActionLayer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _floatItem('알바', '$basePath/fab/fab_01.png'),
                            _floatItem('과외/클래스', '$basePath/fab/fab_02.png'),
                            _floatItem('농수산물', '$basePath/fab/fab_03.png'),
                            _floatItem('부동산', '$basePath/fab/fab_04.png'),
                            _floatItem('중고차', '$basePath/fab/fab_05.png'),
                          ],
                        ),
                      ),
                      const Height(3),
                      Container(
                        width: 160,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(right: 15, bottom: 10),
                        decoration: BoxDecoration(
                            color: context.appColors.floatingActionLayer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _floatItem('내 물건 팔기', '$basePath/fab/fab_06.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  height: 60,
                  duration: 100.ms,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: isExpanded ? context.appColors.floatingActionLayer : Colors.orange,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedRotation(
                          child: Icon(Icons.add), duration: 100.ms, turns: isExpanded ? 0.125 : 0),
                      AnimatedWidthCollapse(
                        visible: !isSmall,
                        duration: 100.ms,
                        child: '글쓰기'.text.white.make(),
                      )
                    ],
                  ),
                ).pOnly(bottom: 80, right: 15),
              ],
            ),
          ),
        )
      ],
    );
  }

  _floatItem(String title, String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 30,
        ),
        const Width(8),
        title.text.make(),
      ],
    );
  }
}

class AnimatedWidthCollapse extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Duration duration;

  const AnimatedWidthCollapse({
    super.key,
    required this.visible,
    required this.child,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      child: Container(
        constraints: visible
            ? const BoxConstraints(
                maxWidth: double.infinity,
              )
            : const BoxConstraints(
                maxWidth: 0.0,
              ),
        child: visible ? child : Container(),
      ),
    );
  }
}
