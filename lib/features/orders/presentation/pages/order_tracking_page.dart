import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late List<LatLng> _route;
  late LatLng _currentBikePos;
  double _trackingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // Coordinates simulating a route in Chennai
    _route = [
      const LatLng(13.0860, 80.2100), // Start: Restaurant
      const LatLng(13.0845, 80.2110),
      const LatLng(13.0830, 80.2115),
      const LatLng(13.0820, 80.2130),
      const LatLng(13.0810, 80.2140), // End: Home
    ];
    _currentBikePos = _route.first;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _animController.addListener(() {
      _trackingProgress = _animController.value;
      double segmentProgress = _trackingProgress * (_route.length - 1);
      int index = segmentProgress.floor();

      if (index >= _route.length - 1) {
        _currentBikePos = _route.last;
      } else {
        double t = segmentProgress - index;
        LatLng p1 = _route[index];
        LatLng p2 = _route[index + 1];

        // Linear interpolation between the two points for the bike
        double lat = p1.latitude + (p2.latitude - p1.latitude) * t;
        double lng = p1.longitude + (p2.longitude - p1.longitude) * t;
        
        if (mounted) {
          setState(() {
            _currentBikePos = LatLng(lat, lng);
          });
        }
      }
    });

    // Start tracking animation automatically
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Real OpenStreetMap Background with Flutter Map
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(13.0835, 80.2120),
                initialZoom: 16.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.undu_magizh.app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _route,
                      color: AppColors.primary,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    // Restaurant Marker
                    Marker(
                      point: _route.first,
                      width: 40, height: 40,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
                        child: const Icon(Icons.store, color: Colors.blue, size: 20),
                      ),
                    ),
                    // Home Marker
                    Marker(
                      point: _route.last,
                      width: 40, height: 40,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.green, width: 2)),
                        child: const Icon(Icons.home, color: Colors.green, size: 20),
                      ),
                    ),
                    // Animated Bike Marker
                    Marker(
                      point: _currentBikePos,
                      width: 46, height: 46,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 6, offset: const Offset(0, 3))],
                        ),
                        child: const Icon(Icons.two_wheeler, color: AppColors.primary, size: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Floating Action Buttons (Top Bar)
          Positioned(
            top: 50, left: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            top: 50, right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
              ),
              child: const Text('Help', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
            ),
          ),

          // Live Tracking Panel bottom sheet style
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40, // Pulled slightly up
            left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -5)),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 12),
                        width: 40, height: 4,
                        decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                    _buildTrackingStatus(),
                    _buildRiderInfo(),
                    _buildDetailedTimeline(),
                    _buildOrderSummary(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStatus() {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _trackingProgress < 0.95 ? 'Arriving shortly' : 'Order Delivered!',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textPrimary, letterSpacing: -0.5),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _trackingProgress < 0.95 ? 'ETA: 5 mins' : 'Delivered',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Anna Nagar, Chennai', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          
          // Animated Tracking Bar
          Stack(
            children: [
              Container(
                height: 6,
                margin: const EdgeInsets.only(top: 14),
                decoration: BoxDecoration(color: AppColors.divider.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(3)),
              ),
              FractionallySizedBox(
                widthFactor: 0.3 + (_trackingProgress * 0.7), // Starts from 30% (picked up) out to 100%
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.only(top: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primaryLight, AppColors.primary]),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTrackNode(Icons.receipt_long, true),
                  _buildTrackNode(Icons.restaurant, true),
                  _buildTrackNode(Icons.delivery_dining, _trackingProgress > 0.0),
                  _buildTrackNode(Icons.home, _trackingProgress > 0.95),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackNode(IconData icon, bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.primary : AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: isCompleted ? AppColors.primary : AppColors.divider, width: 2),
      ),
      child: Icon(icon, size: 16, color: isCompleted ? AppColors.white : AppColors.textHint),
    );
  }

  Widget _buildRiderInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.divider, width: 2),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=200'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -5, right: -5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: const [
                      Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                      Icon(Icons.star, color: Colors.orange, size: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Suresh Kumar', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                SizedBox(height: 4),
                Text('Delivery Partner', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Row(
            children: [
              _buildCircleButton(Icons.call, Colors.green),
              const SizedBox(width: 12),
              _buildCircleButton(Icons.message, AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildDetailedTimeline() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Track Order Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 20),
          _buildTimelineTile('Order Accepted', '08:20 PM', isCompleted: true),
          _buildTimelineTile('Food prepared & Picked up', 'Paradise Biryani', isCompleted: true),
          _buildTimelineTile('Rider is on the way', 'Arriving shortly', isCompleted: _trackingProgress > 0.0, isActive: _trackingProgress < 0.95),
          _buildTimelineTile('Order Delivered', 'Home Address', isCompleted: _trackingProgress > 0.95, isLast: true, isActive: _trackingProgress > 0.95),
        ],
      ),
    );
  }

  Widget _buildTimelineTile(String title, String subtitle, {bool isCompleted = false, bool isLast = false, bool isActive = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12, height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColors.primary : (isCompleted ? Colors.green : AppColors.divider),
                border: isActive ? Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 3) : null,
              ),
            ),
            if (!isLast)
              Container(
                width: 2, height: 30, // line height
                color: isCompleted ? Colors.green : AppColors.divider,
                margin: const EdgeInsets.symmetric(vertical: 2),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.w500,
                    color: isCompleted || isActive ? AppColors.textPrimary : AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Order Summary', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              Text('ID: #UNDU987654321', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text('1x  Premium Special Dish', style: TextStyle(fontWeight: FontWeight.w600)),
              Spacer(),
              Text('₹250', style: TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: const [
              Text('Total Amount Paid', style: TextStyle(fontWeight: FontWeight.w800)),
              Spacer(),
              Text('₹308', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }
}
