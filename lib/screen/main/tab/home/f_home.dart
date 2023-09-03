import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../detail/s_product_detail.dart';
import '../../fab/floating_small_provider.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      final isSmall = ref.read(isFloatingButtonSmallProvider);
      if (scrollController.position.pixels > 100 && !isSmall) {
        ref.read(isFloatingButtonSmallProvider.notifier).change(ref, true);
      } else if (scrollController.position.pixels < 100 && isSmall) {
        ref.read(isFloatingButtonSmallProvider.notifier).change(ref, false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        Tap(
            onTap: (){
              ref.invalidate(detailDataProvider(1));
              Nav.push(ProductDetailScreen(id: 1,));

            },
            child: Container(height: 500, color: Colors.red)),
        Tap(
            onTap: (){
              ref.invalidate(detailDataProvider(2));
              Nav.push(ProductDetailScreen(id: 2,));

            },
            child: Container(height: 500, color: Colors.blue)),
        Container(height: 500, color: Colors.red),
        Container(height: 500, color: Colors.blue),
        Container(height: 500, color: Colors.red),
        Container(height: 500, color: Colors.blue),
      ],
    );
  }
}
