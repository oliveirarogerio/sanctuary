import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Screen displaying user's favorite pets
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favorites),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    // TODO: Replace with actual favorites from Firebase
    final mockFavorites = _getMockFavorites();
    
    if (mockFavorites.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      itemCount: mockFavorites.length,
      itemBuilder: (context, index) {
        final pet = mockFavorites[index];
        return _buildFavoriteCard(pet);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: AppDimensions.spaceLarge),
          Text(
            'No favorites yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          Text(
            'Browse pets and tap the heart icon to add them to your favorites',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          ElevatedButton.icon(
            onPressed: () => context.go('/browse'),
            icon: const Icon(Icons.pets),
            label: const Text('Browse Pets'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> pet) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMedium),
      child: ListTile(
        leading: Container(
          width: AppDimensions.listItemImageSize,
          height: AppDimensions.listItemImageSize,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Icon(
            Icons.pets,
            color: _getPetColor(pet['species']),
          ),
        ),
        title: Text(pet['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${pet['species']} • ${pet['breed']}'),
            const SizedBox(height: AppDimensions.spaceSmall),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: AppDimensions.iconSmall,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppDimensions.spaceSmall),
                Text(
                  pet['location'],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () => _removeFavorite(pet),
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          tooltip: AppStrings.unfavorite,
        ),
        onTap: () => context.push('/browse/pet/${pet['id']}'),
      ),
    );
  }

  void _removeFavorite(Map<String, dynamic> pet) {
    // TODO: Implement remove from favorites
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pet['name']} removed from favorites'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
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
      default:
        return AppColors.otherPetColor;
    }
  }

  List<Map<String, dynamic>> _getMockFavorites() {
    return [
      {
        'id': '3',
        'name': 'Charlie',
        'species': 'Bird',
        'breed': 'Parrot',
        'location': 'Seattle, WA',
      },
      {
        'id': '4',
        'name': 'Daisy',
        'species': 'Rabbit',
        'breed': 'Holland Lop',
        'location': 'Portland, OR',
      },
    ];
  }
} 