import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/explore_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _categories = [
    {
      'name': 'All',
      'image':
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=200',
    },
    {
      'name': 'Meals',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200',
    },
    {
      'name': 'Biryani',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200',
    },
    {
      'name': 'Chicken',
      'image':
          'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=200',
    },
    {
      'name': 'Mutton',
      'image':
          'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=200',
    },
  ];

  final List<Map<String, dynamic>> _exploreItems = [
    {
      'name': 'Paradise Biryani',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=600',
      'cuisine': 'Biryani, North Indian, Chinese',
      'rating': 4.3,
      'distance': '2.5 km',
      'deliveryTime': '30-35 min',
      'price': '₹250 for two',
      'isVeg': false,
      'offer': '50% OFF up to ₹100',
    },
    {
      'name': 'Green Leaf Restaurant',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
      'cuisine': 'South Indian, Pure Veg',
      'rating': 4.5,
      'distance': '1.8 km',
      'deliveryTime': '25-30 min',
      'price': '₹200 for two',
      'isVeg': true,
      'offer': '40% OFF up to ₹80',
    },
    {
      'name': 'Tandoor House',
      'image':
          'https://images.unsplash.com/photo-1610057099443-fde8c4d50f91?w=600',
      'cuisine': 'North Indian, Tandoor, Kebabs',
      'rating': 4.6,
      'distance': '3.2 km',
      'deliveryTime': '35-40 min',
      'price': '₹350 for two',
      'isVeg': false,
      'offer': '60% OFF up to ₹120',
    },
    {
      'name': 'Dosa Plaza',
      'image':
          'https://images.unsplash.com/photo-1630383249896-424e482df921?w=600',
      'cuisine': 'South Indian, Dosa, Breakfast',
      'rating': 4.4,
      'distance': '1.5 km',
      'deliveryTime': '20-25 min',
      'price': '₹150 for two',
      'isVeg': true,
      'offer': '30% OFF',
    },
    {
      'name': 'Spice Garden',
      'image':
          'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=600',
      'cuisine': 'Indian, Chinese, Continental',
      'rating': 4.2,
      'distance': '2.8 km',
      'deliveryTime': '30-35 min',
      'price': '₹300 for two',
      'isVeg': false,
      'offer': '50% OFF up to ₹100',
    },
    {
      'name': 'Pizza Hut',
      'image':
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
      'cuisine': 'Pizza, Fast Food, Italian',
      'rating': 4.1,
      'distance': '2.0 km',
      'deliveryTime': '25-35 min',
      'price': '₹400 for two',
      'isVeg': true,
      'offer': 'FREE delivery',
    },
    {
      'name': 'Burger King',
      'image':
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=600',
      'cuisine': 'Burgers, Fast Food, American',
      'rating': 4.2,
      'distance': '1.2 km',
      'deliveryTime': '20-25 min',
      'price': '₹300 for two',
      'isVeg': false,
      'offer': '20% OFF',
    },
    {
      'name': 'Ocean Delight',
      'image':
          'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600',
      'cuisine': 'Seafood, Goan, Coastal',
      'rating': 4.7,
      'distance': '4.5 km',
      'deliveryTime': '40-45 min',
      'price': '₹800 for two',
      'isVeg': false,
      'offer': '10% OFF',
    },
    {
      'name': 'Sweet Sensations',
      'image':
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600',
      'cuisine': 'Desserts, Bakery, Cakes',
      'rating': 4.8,
      'distance': '0.8 km',
      'deliveryTime': '15-20 min',
      'price': '₹200 for two',
      'isVeg': true,
      'offer': 'Buy 1 Get 1',
    },
    {
      'name': 'The Salad Bar',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
      'cuisine': 'Healthy, Salads, Continental',
      'rating': 4.5,
      'distance': '2.1 km',
      'deliveryTime': '25-30 min',
      'price': '₹500 for two',
      'isVeg': true,
      'offer': 'FREE delivery',
    },
    {
      'name': 'Sushi Express',
      'image':
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=600',
      'cuisine': 'Japanese, Sushi, Asian',
      'rating': 4.6,
      'distance': '3.8 km',
      'deliveryTime': '35-40 min',
      'price': '₹1200 for two',
      'isVeg': false,
      'offer': '15% OFF',
    },
    {
      'name': 'Punjabi Dhaba',
      'image':
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600',
      'cuisine': 'North Indian, Punjabi, Authentic',
      'rating': 4.4,
      'distance': '2.4 km',
      'deliveryTime': '30-35 min',
      'price': '₹400 for two',
      'isVeg': false,
      'offer': '30% OFF up to ₹100',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: AppSizes.paddingM),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: 'Search for restaurants, dishes...',
              hintStyle: const TextStyle(color: AppColors.textHint),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.primary,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic, color: AppColors.primary, size: 20),
                onPressed: () {},
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed Header Section (Doesn't scroll)
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.only(bottom: AppSizes.paddingM),
            child: Column(
              children: [
                const SizedBox(height: AppSizes.spaceL),
                // Horizontal Categories (Circular like image)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSizes.spaceL),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.divider,
                                  width: 1,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _categories[index]['image']!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _categories[index]['name']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: AppSizes.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // EXPLORE MORE Label
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EXPLORE MORE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                  // Restaurant Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                    ),
                    child: Column(
                      children: _exploreItems.map((item) {
                        return ExploreCard(
                          imageUrl: item['image'],
                          name: item['name'],
                          cuisine: item['cuisine'],
                          rating: item['rating'],
                          distance: item['distance'],
                          deliveryTime: item['deliveryTime'],
                          price: item['price'],
                          isVeg: item['isVeg'],
                          offer: item['offer'],
                          onTap: () {},
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
