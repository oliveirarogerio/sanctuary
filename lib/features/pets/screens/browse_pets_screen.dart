import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/theme_toggle_button.dart';

/// Browse pets screen - main screen for viewing available pets
class BrowsePetsScreen extends StatefulWidget {
  const BrowsePetsScreen({super.key});

  @override
  State<BrowsePetsScreen> createState() => _BrowsePetsScreenState();
}

class _BrowsePetsScreenState extends State<BrowsePetsScreen> {
  final _searchController = TextEditingController();
  String _selectedSpecies = 'All';
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AppBar(
              backgroundColor: isDark
                  ? AppColors.glassBackgroundDark.withOpacity(0.8)
                  : AppColors.glassBackground.withOpacity(0.9),
              elevation: 0,
              title: Row(
                children: [
                  Icon(
                    Icons.pets,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.browse,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              actions: [
                const ThemeToggleButton(),
                IconButton(
                  onPressed: () => context.push('/login'),
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  tooltip: 'Profile',
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search and filter section with modern design
            _buildSearchAndFilter(),
            
            // Pet listings with enhanced cards
            Expanded(
              child: _buildPetGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Modern search bar
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.glassShadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for your perfect companion...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.textLightDark : AppColors.textLight,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.textSecondary,
                        ),
                      )
                    : null,
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {});
                // TODO: Implement search functionality
              },
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          
          // Enhanced filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', Icons.pets),
                _buildFilterChip(AppStrings.dog, Icons.pets, AppColors.dogColor),
                _buildFilterChip(AppStrings.cat, Icons.pets, AppColors.catColor),
                _buildFilterChip(AppStrings.bird, Icons.flutter_dash, AppColors.birdColor),
                _buildFilterChip(AppStrings.rabbit, Icons.cruelty_free, AppColors.rabbitColor),
                _buildFilterChip(AppStrings.other, Icons.favorite, AppColors.otherPetColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, [Color? categoryColor]) {
    final isSelected = _selectedSpecies == label;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor = categoryColor ?? AppColors.primary;
    
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: FilterChip(
          avatar: Icon(
            icon,
            size: 18,
            color: isSelected
                ? Colors.white
                : chipColor,
          ),
          label: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 14,
            ),
          ),
          selected: isSelected,
          backgroundColor: isDark
              ? AppColors.surfaceDark
              : AppColors.surface,
          selectedColor: chipColor,
          checkmarkColor: Colors.white,
          elevation: isSelected ? 4 : 1,
          shadowColor: chipColor.withOpacity(0.3),
          side: BorderSide(
            color: isSelected 
                ? chipColor
                : (isDark ? AppColors.glassBorderDark : AppColors.separator),
            width: isSelected ? 2 : 1,
          ),
          onSelected: (selected) {
            setState(() {
              _selectedSpecies = selected ? label : 'All';
            });
          },
        ),
      ),
    );
  }

  Widget _buildPetGrid() {
    // TODO: Replace with actual data from Firebase
    final mockPets = _getMockPets();
    
    if (mockPets.isEmpty) {
      return _buildEmptyState();
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: mockPets.length,
      itemBuilder: (context, index) {
        final pet = mockPets[index];
        return _buildModernPetCard(pet);
      },
    );
  }

  Widget _buildModernPetCard(Map<String, dynamic> pet) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => context.push('/browse/pet/${pet['id']}'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.glassShadow.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet image with favorite button
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _getPetColor(pet['species']).withOpacity(0.3),
                            _getPetColor(pet['species']).withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getPetIcon(pet['species']),
                          size: 60,
                          color: _getPetColor(pet['species']),
                        ),
                      ),
                    ),
                    // Favorite button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.glassShadow.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: AppColors.heartColor,
                        ),
                      ),
                    ),
                    // Adoption status badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.available,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Available',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Pet details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pet name
                      Text(
                        pet['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Pet breed and age
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${pet['breed']} • ${pet['age']}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              pet['location'],
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: AppDimensions.spaceLarge),
          Text(
            AppStrings.noResults,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPetColor(String species) {
    switch (species.toLowerCase()) {
      case 'dog':
        return AppColors.dogColor;
      case 'cat':
        return AppColors.catColor;
      case 'bird':
        return AppColors.birdColor;
      case 'rabbit':
        return AppColors.rabbitColor;
      default:
        return AppColors.otherPetColor;
    }
  }

  IconData _getPetIcon(String species) {
    switch (species.toLowerCase()) {
      case 'dog':
      case 'cat':
        return Icons.pets;
      case 'bird':
        return Icons.flutter_dash;
      case 'rabbit':
        return Icons.cruelty_free;
      default:
        return Icons.favorite;
    }
  }

  List<Map<String, dynamic>> _getMockPets() {
    return [
      {
        'id': '1',
        'name': 'Buddy',
        'species': 'Dog',
        'breed': 'Golden Retriever',
        'age': 3,
        'location': 'San Francisco, CA',
        'status': 'Available',
      },
      {
        'id': '2',
        'name': 'Luna',
        'species': 'Cat',
        'breed': 'Persian',
        'age': 2,
        'location': 'Los Angeles, CA',
        'status': 'Available',
      },
      {
        'id': '3',
        'name': 'Charlie',
        'species': 'Bird',
        'breed': 'Parrot',
        'age': 1,
        'location': 'Seattle, WA',
        'status': 'Available',
      },
      {
        'id': '4',
        'name': 'Daisy',
        'species': 'Rabbit',
        'breed': 'Holland Lop',
        'age': 2,
        'location': 'Portland, OR',
        'status': 'Available',
      },
    ];
  }
} 