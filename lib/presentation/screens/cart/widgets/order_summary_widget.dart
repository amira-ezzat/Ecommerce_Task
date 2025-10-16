import 'package:flutter/material.dart';
import '../../../../logic/cart/cart_state.dart';
import '../../../../core/styles/app_texts.dart';
import '../../../../core/utils/app_colors.dart';

class OrderSummaryWidget extends StatelessWidget {
  final CartLoaded state;
  const OrderSummaryWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _SummaryRow(
              title: 'Total (${state.items.length} items)',
              value: '\$${state.subtotal.toStringAsFixed(2)}',
              isDark: isDark,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _SummaryRow(
              title: 'Shipping fee',
              value: '\$${state.shipping.toStringAsFixed(2)}',
              isDark: isDark,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(data: 'Total').SemiBold16(
                        context,
                        color: isDark ? Colors.white70 : AppColors.grey7,
                      ),
                      AppTexts(
                        data: '\$${state.total.toStringAsFixed(2)}',
                      ).Bold20(
                        context,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: AppTexts(data: 'Checkout').medium16White(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isDark;

  const _SummaryRow({
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts(data: title).SemiBold16(
          context,
          color: isDark ? Colors.white70 : AppColors.grey7,
        ),
        AppTexts(data: value).SemiBold14(
          context,
          color: isDark ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}
