import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/location_badge.dart';
import '../widgets/search_bar_widget.dart';

/// Explore page - Main discovery screen
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentCarouselIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  final List<String> _carouselImages = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
    'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?w=800',
    'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800',
    'https://images.unsplash.com/photo-1493770348161-369560ae357d?w=800',
    'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800',
  ];

  final List<Map<String, String>> _foodCategories = [
    {
      'name': 'All',
      'image':
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400',
    },
    {
      'name': 'Meals',
      'image':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
    },
    {
      'name': 'Biryani',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400',
    },
    {
      'name': 'Chicken',
      'image':
          'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=400',
    },
    {
      'name': 'Mutton',
      'image':
          'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=400',
    },
    {
      'name': 'Fish',
      'image':
          'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400',
    },
    {
      'name': 'Veg',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
    },
    {
      'name': 'Starters',
      'image':
          'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=400',
    },
    {
      'name': 'Desserts',
      'image':
          'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400',
    },
    {
      'name': 'Beverages',
      'image':
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400',
    },
  ];

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final screenHeight = context.screenHeight;
    final carouselHeight = screenHeight * 0.3;

    // Check if scrolled past the carousel
    final isCollapsed =
        _scrollController.hasClients &&
        _scrollController.offset > (carouselHeight - kToolbarHeight);

    if (isCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isCollapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final carouselHeight = screenHeight * 0.3; // 30% for carousel

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverAppBar with carousel
          SliverAppBar(
            pinned: true,
            expandedHeight: carouselHeight,
            collapsedHeight: 70,
            // Increased height for collapsed state
            toolbarHeight: 70,
            // Increased toolbar height
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shape: _isCollapsed
                ? Border(
                    bottom: BorderSide(
                      color: AppColors.border,
                      width: AppSizes.borderWidthThin,
                    ),
                  )
                : null,
            // Show only search bar when collapsed
            title: _isCollapsed
                ? SearchBarWidget(onTap: () {}, onVoiceTap: () {})
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                    items: _carouselImages.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: double.infinity,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.restaurant_menu,
                                      size: 80,
                                      color: AppColors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  // Dark gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.black.withValues(alpha: 0.3),
                          AppColors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),

                  // Location and Profile on top of carousel
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingM,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSizes.spaceS),
                          // Location and profile row
                          Row(
                            children: [
                              LocationBadge(
                                location: 'Mumbai, Maharashtra',
                                onTap: () {},
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusCircular,
                                ),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(
                                      alpha: 0.95,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'D',
                                      style: TextStyle(
                                        fontSize: AppSizes.fontL,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          // Search bar below location
                          SearchBarWidget(onTap: () {}, onVoiceTap: () {}),
                          AppSizes.heightM,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _carouselImages.asMap().entries.map((
                              entry,
                            ) {
                              return Container(
                                width: _currentCarouselIndex == entry.key
                                    ? 24.0
                                    : 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: _currentCarouselIndex == entry.key
                                      ? AppColors.white
                                      : AppColors.white.withValues(alpha: 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                          AppSizes.heightM,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          // Top spacing
          SliverToBoxAdapter(child: AppSizes.heightL),

          // Sticky horizontal scrollable food categories with images
          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              minHeight: 130,
              maxHeight: 130,
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.only(
                  top: AppSizes.paddingS,
                  bottom: AppSizes.paddingS,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                  ),
                  itemCount: _foodCategories.length,
                  itemBuilder: (context, index) {
                    final category = _foodCategories[index];
                    final isSelected = _selectedCategoryIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSizes.spaceL),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Category image
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusCircular,
                                ),
                                border: isSelected
                                    ? Border.all(
                                        color: AppColors.primary,
                                        width: AppSizes.borderWidthThick,
                                      )
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withValues(
                                      alpha: 0.08,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusCircular,
                                ),
                                child: Image.network(
                                  category['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.2,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.restaurant,
                                          size: AppSizes.iconL,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceS),
                            // Category name
                            Text(
                              category['name']!,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontSize: AppSizes.fontS,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Bottom spacing
          SliverToBoxAdapter(child: const SizedBox(height: 700)),
        ],
      ),
    );
  }
}

/// Custom delegate for sticky category header
class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _CategoryHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_CategoryHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
