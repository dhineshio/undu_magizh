import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  
  final List<String> _carouselImages = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
    'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?w=800',
    'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800',
    'https://images.unsplash.com/photo-1493770348161-369560ae357d?w=800',
    'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=800',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final carouselHeight = screenHeight * 0.3; // 30% for carousel

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with carousel
          SliverAppBar(
            pinned: true,
            expandedHeight: carouselHeight,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
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
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                                  color: AppColors.primary.withValues(alpha: 0.2),
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
                                borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(alpha: 0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withValues(alpha: 0.1),
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
                          SearchBarWidget(
                            onTap: () {},
                            onVoiceTap: () {},
                          ),
                          AppSizes.heightM,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _carouselImages.asMap().entries.map((entry) {
                              return Container(
                                width: _currentCarouselIndex == entry.key ? 24.0 : 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
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

          // Content area
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSizes.spaceL),
                const Center(
                  child: Text('Content Area - Ready'),
                ),
                const SizedBox(height: 700),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
