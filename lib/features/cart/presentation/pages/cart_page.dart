import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../orders/presentation/pages/order_success_page.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic> itemData;
  final int quantity;

  const CartPage({
    super.key,
    required this.itemData,
    required this.quantity,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int _currentQuantity;
  final double _itemPrice = 250.0; 
  bool _isUtensilsOpted = false;
  String _selectedInstruction = '';

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.quantity;
  }

  double get _itemTotal => _itemPrice * _currentQuantity;
  double get _deliveryFee => 40.0;
  double get _taxes => _itemTotal * 0.05;
  double get _platformFee => 5.0;
  double get _grandTotal => _itemTotal + _deliveryFee + _taxes + _platformFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paradise Biryani',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: AppSizes.fontL,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'Anna Nagar, Chennai',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: AppSizes.fontXS,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildItemsSection(),
            _buildOptInUtensils(),
            _buildOffersSection(),
            _buildDeliveryInstructions(),
            _buildBillDetails(),
            _buildTipSection(),
            _buildCancellationPolicy(),
            const SizedBox(height: 180), // Padding for the bottom sheet
          ],
        ),
      ),
      bottomSheet: _buildCheckoutBottomBar(),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.itemData['image'] ?? 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red.shade600, width: 1.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.circle, color: Colors.red.shade600, size: 8),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.itemData['name'] ?? 'Premium Special Dish',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '₹${_itemPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textSecondary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildQuantitySelector(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '₹${_itemTotal.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.textPrimary),
              ),
            ],
          ),
          const Divider(height: 32, color: AppColors.divider),
          InkWell(
            onTap: () => Navigator.pop(context),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Add more items',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.edit_note, color: AppColors.textSecondary, size: 20),
                prefixIconConstraints: BoxConstraints(minWidth: 40),
                hintText: 'Add cooking instructions (e.g. make it spicy)',
                hintStyle: TextStyle(color: AppColors.textHint, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (_currentQuantity > 1) {
                setState(() => _currentQuantity--);
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Icon(Icons.remove, size: 16, color: AppColors.primary),
            ),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 16),
            alignment: Alignment.center,
            child: Text(
              '$_currentQuantity',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: AppColors.primary),
            ),
          ),
          InkWell(
            onTap: () => setState(() => _currentQuantity++),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Icon(Icons.add, size: 16, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptInUtensils() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: const BorderSide(color: AppColors.textHint, width: 1.5),
          ),
        ),
        child: CheckboxListTile(
          value: _isUtensilsOpted,
          onChanged: (val) => setState(() => _isUtensilsOpted = val ?? false),
          activeColor: AppColors.primary,
          title: const Text('Opt in for No-Contact Cutlery', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
          subtitle: const Text('Help us reduce plastic waste by only asking for cutlery if you need it.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3)),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildOffersSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3), style: BorderStyle.none),
            ),
            child: Row(
              children: [
                Icon(Icons.local_offer, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'View Offers & Promocodes',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Save big on your order today!',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.blue.shade800),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.blue.shade700),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryInstructions() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Instructions',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildInstructionChip(Icons.mic_off, 'Avoid calling'),
                _buildInstructionChip(Icons.notifications_off, 'Don\'t ring bell'),
                _buildInstructionChip(Icons.place, 'Leave at door'),
                _buildInstructionChip(Icons.security, 'Leave with guard'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionChip(IconData icon, String label) {
    bool isSelected = _selectedInstruction == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedInstruction = isSelected ? '' : label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 90,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.white,
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider.withValues(alpha: 0.5), width: isSelected ? 1.5 : 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [] : [
            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              const Text('Add a tip for your rider', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTipChip('₹10'),
              _buildTipChip('₹20'),
              _buildTipChip('₹30'),
              _buildTipChip('Custom'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipChip(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(amount, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textPrimary)),
    );
  }

  Widget _buildBillDetails() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill Details',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          _buildBillRow('Item Total', _itemTotal),
          const SizedBox(height: 10),
          _buildBillRow('Delivery partner fee', _deliveryFee, info: '2.5 km away', isFee: true),
          const SizedBox(height: 10),
          _buildBillRow('Taxes & Charges', _taxes),
          const SizedBox(height: 10),
          _buildBillRow('Platform Fee', _platformFee),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.divider, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.textPrimary),
              ),
              Text(
                '₹${_grandTotal.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String title, double amount, {String? info, bool isFee = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 13)),
            if (info != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.info_outline, size: 14, color: AppColors.textHint),
            ]
          ],
        ),
        Text('₹${amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isFee ? AppColors.primary : AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildCancellationPolicy() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.divider.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cancellation Policy',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            'Orders cannot be cancelled once packed for delivery. In case of unexpected delays, a refund will be provided if applicable.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Address Row
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.home, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Delivering to Home', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)),
                          SizedBox(height: 2),
                          Text('123, Main Street, Anna Nagar...', style: TextStyle(color: AppColors.textSecondary, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('CHANGE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              // Pay Button FIXED ALIGNMENT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Added horizontal padding!
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Ensures tight wrap
                        children: [
                          Text('₹${_grandTotal.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                          const Text('TOTAL', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 0.5)),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Place Order', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 14),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
