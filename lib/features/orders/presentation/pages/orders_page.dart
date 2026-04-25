import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/active_order_card.dart';
import '../widgets/order_card.dart';

/// Premium User-App Orders Page
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _activeOrders = [
    {
      'restaurantName': 'Paradise Biryani',
      'status': 'Preparing your food...',
      'imageUrl': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400',
      'estimatedTime': 12,
      'progress': 0.4,
    },
  ];

  final List<Map<String, dynamic>> _pastOrders = [
    {
      'restaurantName': 'Green Leaf Restaurant',
      'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      'items': '2x Masala Dosa, 1x Filter Coffee',
      'date': '12 Mar, 2024 • 08:30 PM',
      'amount': 350.0,
      'status': 'Delivered',
    },
    {
      'restaurantName': 'Tandoor House',
      'imageUrl': 'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=400',
      'items': '1x Butter Chicken, 3x Garlic Naan',
      'date': '10 Mar, 2024 • 09:15 PM',
      'amount': 580.0,
      'status': 'Delivered',
    },
    {
      'restaurantName': 'Dosa Plaza',
      'imageUrl': 'https://images.unsplash.com/photo-1630383249896-424e482df921?w=400',
      'items': '1x Onion Rava Dosa, 1x Vada',
      'date': '08 Mar, 2024 • 09:00 AM',
      'amount': 180.0,
      'status': 'Cancelled',
    },
    {
      'restaurantName': 'Spice Garden',
      'imageUrl': 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=400',
      'items': '1x Veg Pulao, 1x Paneer Butter Masala',
      'date': '05 Mar, 2024 • 01:30 PM',
      'amount': 450.0,
      'status': 'Delivered',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isSearching ? 80 : 70,
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: 8),
              child: _isSearching ? _buildSearchBar() : _buildNormalHeader(),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              decoration: BoxDecoration(
                color: AppColors.divider.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.all(4),
                tabs: const [
                  Tab(text: 'ACTIVE'),
                  Tab(text: 'PAST'),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.paddingS),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActiveOrdersList(),
                  _buildPastOrdersList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrdersList() {
    final filteredOrders = _activeOrders.where((order) {
      final name = order['restaurantName'].toString().toLowerCase();
      final status = order['status'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || status.contains(query);
    }).toList();

    if (filteredOrders.isEmpty) {
      return _buildEmptyState(_searchQuery.isEmpty ? 'No active orders right now' : 'No matching orders found');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      physics: const BouncingScrollPhysics(),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return ActiveOrderCard(
          restaurantName: order['restaurantName'],
          status: order['status'],
          imageUrl: order['imageUrl'],
          estimatedTime: order['estimatedTime'],
          progress: order['progress'],
        );
      },
    );
  }

  Widget _buildPastOrdersList() {
    final filteredOrders = _pastOrders.where((order) {
      final name = order['restaurantName'].toString().toLowerCase();
      final items = order['items'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || items.contains(query);
    }).toList();

    if (filteredOrders.isEmpty) {
      return _buildEmptyState(_searchQuery.isEmpty ? 'You haven\'t ordered anything yet' : 'No matching history found');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      physics: const BouncingScrollPhysics(),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return OrderCard(
          restaurantName: order['restaurantName'],
          imageUrl: order['imageUrl'],
          items: order['items'],
          date: order['date'],
          amount: order['amount'],
          status: order['status'],
          onReorder: () {},
          onRate: () {},
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.divider.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: AppColors.textHint.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: AppSizes.spaceL),
          Text(
            message,
            style: TextStyle(
              fontSize: AppSizes.fontM,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.spaceL),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              elevation: 0,
            ),
            child: const Text('EXPLORE RESTAURANTS', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalHeader() {
    return Row(
      children: [
        const Text(
          'Order History',
          style: TextStyle(
            fontSize: AppSizes.fontXXL,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
          icon: const Icon(Icons.search, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.divider.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: const TextStyle(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: 'Search by restaurant or food...',
          hintStyle: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.normal),
          prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _isSearching = false;
                _searchQuery = '';
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }
}
