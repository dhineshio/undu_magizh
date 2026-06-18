import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> orderData;
  final bool isActive;

  const OrderDetailsPage({
    super.key,
    required this.orderData,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: AppSizes.fontL,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Help',
              style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildStatusHeader(),
            _buildRestaurantInfo(),
            _buildOrderItems(),
            _buildBillDetails(),
            _buildDeliveryDetails(),
            const SizedBox(height: AppSizes.paddingL),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isActive ? Icons.delivery_dining : Icons.check_circle,
                color: isActive ? AppColors.primary : AppColors.success,
                size: 28,
              ),
              const SizedBox(width: AppSizes.paddingS),
              Expanded(
                child: Text(
                  isActive ? 'Arriving in ${orderData['estimatedTime'] ?? 15} mins' : 'Order Delivered',
                  style: const TextStyle(
                    fontSize: AppSizes.fontXL,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            isActive ? 'Your order is on the way.' : 'Delivered on ${orderData['date'] ?? 'recently'}',
            style: const TextStyle(
              fontSize: AppSizes.fontS,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            child: Image.network(
              orderData['imageUrl'] ?? 'https://via.placeholder.com/150',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderData['restaurantName'] ?? 'Restaurant Name',
                  style: const TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Anna Nagar, Chennai', // Placeholder location
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Order ID: #UNDU987654321',
                  style: TextStyle(
                    fontSize: AppSizes.fontXS,
                    color: AppColors.textHint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    // In a real app, items would be a list. Here we mock from the summary string.
    final itemsString = orderData['items'] ?? '1 x Item';
    final items = itemsString.split(', ');

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Order',
            style: TextStyle(
              fontSize: AppSizes.fontL,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.paddingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.circle, size: 8, color: Colors.green),
                ),
                const SizedBox(width: AppSizes.paddingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '₹150.00', // MOCKED individual price
                        style: TextStyle(
                          fontSize: AppSizes.fontS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBillDetails() {
    final double itemTotal = orderData['amount'] ?? 350.0;
    final double taxes = itemTotal * 0.05; // 5% GST
    final double deliveryFee = 40.0;
    final double grandTotal = itemTotal + taxes + deliveryFee;

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill Details',
            style: TextStyle(
              fontSize: AppSizes.fontL,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          _buildBillRow('Item Total', itemTotal),
          const SizedBox(height: 8),
          _buildBillRow('Delivery Fee', deliveryFee, isDiscount: false),
          const SizedBox(height: 8),
          _buildBillRow('Taxes & Charges', taxes),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingS),
            child: Divider(color: AppColors.divider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '₹${grandTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingS),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: Row(
              children: const [
                Icon(Icons.payment, size: 20, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'PAID VIA UPI',
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillRow(String title, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.fontS,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${isDiscount ? '-' : ''}₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: AppSizes.fontS,
            color: isDiscount ? AppColors.success : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryDetails() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(
              fontSize: AppSizes.fontL,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.home_outlined, color: AppColors.textSecondary, size: 20),
              const SizedBox(width: AppSizes.paddingS),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Delivered to Home',
                      style: TextStyle(
                        fontSize: AppSizes.fontM,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '123, Main Street, Anna Nagar, Chennai - 600040',
                      style: TextStyle(
                        fontSize: AppSizes.fontS,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Row(
        children: [
          if (!isActive) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
                ),
                child: const Text('RATE ORDER', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
          ],
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingM),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
                elevation: 0,
              ),
              child: Text(isActive ? 'TRACK ORDER' : 'REORDER', style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}
