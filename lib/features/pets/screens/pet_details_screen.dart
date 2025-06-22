import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../shared/widgets/glass_card.dart';

/// Pet details screen showing comprehensive information about a specific pet
class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({super.key});

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  bool _isFavorited = false;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Extract petId from route parameters
    final petId = GoRouterState.of(context).pathParameters['petId'];
    final pet = petId != null ? _getMockPetById(petId) : null; // Use petId to get specific pet data
    
    // Handle case where pet is not found
    if (pet == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pet Not Found'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'Pet Not Found',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The pet you\'re looking for doesn\'t exist.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // Hero app bar with pet image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.glassShadow.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.glassShadow.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavorited = !_isFavorited;
                    });
                  },
                  icon: Icon(
                    _isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.heartColor,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getPetColor(pet['species']).withOpacity(0.8),
                      _getPetColor(pet['species']).withOpacity(0.4),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Pet illustration/icon
                    Center(
                      child: Icon(
                        _getPetIcon(pet['species']),
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                    // Status badge
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.available,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.glassShadow.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Available for Adoption',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Pet details content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet name and basic info
                  _buildPetHeader(pet, isDark),
                  const SizedBox(height: 24),
                  
                  // Quick info cards
                  _buildQuickInfoCards(pet, isDark),
                  const SizedBox(height: 24),
                  
                  // About section
                  _buildAboutSection(pet, isDark),
                  const SizedBox(height: 24),
                  
                  // Health & Behavior
                  _buildHealthBehaviorSection(pet, isDark),
                  const SizedBox(height: 24),
                  
                  // Owner info
                  _buildOwnerSection(pet, isDark),
                  const SizedBox(height: 100), // Space for floating button
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildAdoptionButton(isDark),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildPetHeader(Map<String, dynamic> pet, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet['name'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${pet['breed']} • ${pet['gender']}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getPetColor(pet['species']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getPetColor(pet['species']),
                  width: 1,
                ),
              ),
              child: Text(
                pet['species'],
                style: TextStyle(
                  color: _getPetColor(pet['species']),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              pet['location'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickInfoCards(Map<String, dynamic> pet, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Age',
            pet['age'].toString(),
            Icons.cake,
            isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Size',
            pet['size'],
            Icons.straighten,
            isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Weight',
            pet['weight'],
            Icons.monitor_weight,
            isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(Map<String, dynamic> pet, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pets,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'About ${pet['name']}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            pet['description'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthBehaviorSection(Map<String, dynamic> pet, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.health_and_safety,
                color: AppColors.success,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Health & Behavior',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHealthItem('Vaccinated', true, isDark),
          _buildHealthItem('Spayed/Neutered', true, isDark),
          _buildHealthItem('Good with kids', pet['goodWithKids'], isDark),
          _buildHealthItem('Good with other pets', pet['goodWithPets'], isDark),
        ],
      ),
    );
  }

  Widget _buildHealthItem(String title, bool status, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: status 
                  ? AppColors.success.withOpacity(0.1) 
                  : AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              status ? Icons.check : Icons.close,
              color: status ? AppColors.success : AppColors.warning,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerSection(Map<String, dynamic> pet, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.person,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet['ownerName'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pet owner since 2020',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {
              // TODO: Open chat
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Message',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdoptionButton(bool isDark) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Show adoption application form
          _showAdoptionDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 20),
            const SizedBox(width: 8),
            Text(
              'Apply for Adoption',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdoptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Adoption Application'),
        content: const Text(
          'This will open the adoption application form. Feature coming soon!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Got it',
              style: TextStyle(color: AppColors.primary),
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

  Map<String, dynamic>? _getMockPetById(String id) {
    // Mock pet data matching the browse screen pets
    final mockPets = <String, Map<String, dynamic>>{
      '1': {
        'id': '1',
        'name': 'Buddy',
        'species': 'Dog',
        'breed': 'Golden Retriever',
        'age': 3, // Keep as integer to match browse screen
        'gender': 'Male',
        'size': 'Large',
        'weight': '30 kg',
        'location': 'San Francisco, CA',
        'status': 'Available',
        'description': 'Buddy is a friendly and energetic Golden Retriever who loves playing fetch and going on long walks. He\'s great with children and gets along well with other dogs. Buddy is house-trained and knows basic commands. He\'s looking for a loving family who can give him plenty of exercise and affection.',
        'goodWithKids': true,
        'goodWithPets': true,
        'ownerName': 'Mike Thompson',
      },
      '2': {
        'id': '2',
        'name': 'Luna',
        'species': 'Cat',
        'breed': 'Persian',
        'age': 2, // Keep as integer to match browse screen
        'gender': 'Female',
        'size': 'Medium',
        'weight': '4 kg',
        'location': 'Los Angeles, CA',
        'status': 'Available',
        'description': 'Luna is a beautiful and calm Persian cat who loves to be pampered. She enjoys quiet environments and gentle petting. Luna is litter-trained and prefers a peaceful home. She would do best as an only pet with adults or older children.',
        'goodWithKids': false,
        'goodWithPets': false,
        'ownerName': 'Emma Davis',
      },
      '3': {
        'id': '3',
        'name': 'Charlie',
        'species': 'Bird',
        'breed': 'Parrot',
        'age': 1, // Keep as integer to match browse screen
        'gender': 'Male',
        'size': 'Small',
        'weight': '0.5 kg',
        'location': 'Seattle, WA',
        'status': 'Available',
        'description': 'Charlie is a vibrant and intelligent parrot who loves to talk and learn new words. He\'s very social and enjoys interacting with people. Charlie needs an experienced bird owner who can provide mental stimulation and social interaction.',
        'goodWithKids': true,
        'goodWithPets': false,
        'ownerName': 'Alex Chen',
      },
      '4': {
        'id': '4',
        'name': 'Daisy',
        'species': 'Rabbit',
        'breed': 'Holland Lop',
        'age': 2, // Keep as integer to match browse screen
        'gender': 'Female',
        'size': 'Small',
        'weight': '2 kg',
        'location': 'Portland, OR',
        'status': 'Available',
        'description': 'Daisy is a gentle and sweet Holland Lop rabbit who loves to hop around and explore. She\'s litter-trained and enjoys fresh vegetables. Daisy would thrive in a quiet home with a secure outdoor area for exercise.',
        'goodWithKids': true,
        'goodWithPets': true,
        'ownerName': 'Rachel Green',
      },
    };

    return mockPets[id];
  }
} 