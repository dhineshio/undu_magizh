import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/favorite_restaurant_card.dart';

/// Favorites (History) page - Liked restaurants
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> _favorites = [
    {
      'name': 'Paradise Biryani',
      'imageUrl':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400',
      'rating': 4.3,
      'deliveryTime': '30 min',
      'cuisine': 'Biryani, North Indian',
    },
    {
      'name': 'Green Leaf',
      'imageUrl':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'cuisine': 'South Indian, Pure Veg',
    },
    {
      'name': 'Tandoor House',
      'imageUrl':
          'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=400',
      'rating': 4.6,
      'deliveryTime': '35 min',
      'cuisine': 'Tandoor, Kebabs',
    },
    {
      'name': 'Dosa Plaza',
      'imageUrl':
          'https://images.unsplash.com/photo-1630383249896-424e482df921?w=400',
      'rating': 4.4,
      'deliveryTime': '25 min',
      'cuisine': 'South Indian, Dosa',
    },
    {
      'name': 'Spice Garden',
      'imageUrl':
          'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=400',
      'rating': 4.2,
      'deliveryTime': '30 min',
      'cuisine': 'Chinese, Continental',
    },
    {
      'name': 'Pizza Hut',
      'imageUrl':
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      'rating': 4.0,
      'deliveryTime': '40 min',
      'cuisine': 'Pizza, Fast Food',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Favorites',
                          style: TextStyle(
                            fontSize: AppSizes.fontXXL,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'All your liked restaurants in one place',
                      style: TextStyle(
                        fontSize: AppSizes.fontS,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Favorites Grid
            SliverPadding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: AppSizes.spaceM,
                  mainAxisSpacing: AppSizes.spaceM,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final restaurant = _favorites[index];
                  return FavoriteRestaurantCard(
                    name: restaurant['name'],
                    imageUrl: restaurant['imageUrl'],
                    rating: restaurant['rating'],
                    deliveryTime: restaurant['deliveryTime'],
                    cuisine: restaurant['cuisine'],
                    onTap: () {},
                  );
                }, childCount: _favorites.length),
              ),
            ),

            // Bottom Spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
