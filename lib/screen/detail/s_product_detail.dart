import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/network/api.dart';

final detailDataProvider = FutureProviderFamily<(String, DateTime), int>((ref, id) async {
  final data = await Api.getTitle(id);
  return data;
});

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(detailDataProvider(widget.id));

    return value.when(
        data: (data) => Container(
              child: Tap(
                onTap: () {
                  Nav.pop(context);

                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      data.$1.text.make(),
                      data.$2.formattedDateTime.text.make(),
                    ],
                  ),
                ),
              ),
            ),
        error: (error, _) => Container(),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
