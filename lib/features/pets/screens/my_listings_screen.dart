import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Screen displaying user's own pet listings
class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myListings),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    // TODO: Replace with actual user listings
    final mockListings = _getMockListings();
    
    if (mockListings.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      itemCount: mockListings.length,
      itemBuilder: (context, index) {
        final listing = mockListings[index];
        return _buildListingCard(listing);
      },
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
            'No listings yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          Text(
            'Create your first pet listing to help pets find homes',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          ElevatedButton.icon(
            onPressed: () => context.push('/my-listings/create'),
            icon: const Icon(Icons.add),
            label: const Text(AppStrings.addPet),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard(Map<String, dynamic> listing) {
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
            color: _getPetColor(listing['species']),
          ),
        ),
        title: Text(listing['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${listing['species']} • ${listing['breed']}'),
            const SizedBox(height: AppDimensions.spaceSmall),
            _buildStatusChip(listing['status']),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleMenuAction(value, listing),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: AppDimensions.spaceMedium),
                  Text(AppStrings.edit),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppColors.error),
                  SizedBox(width: AppDimensions.spaceMedium),
                  Text(AppStrings.delete),
                ],
              ),
            ),
          ],
        ),
        onTap: () => context.push('/browse/pet/${listing['id']}'),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'available':
        color = AppColors.available;
        break;
      case 'pending':
        color = AppColors.pending;
        break;
      case 'adopted':
        color = AppColors.adopted;
        break;
      default:
        color = AppColors.textSecondary;
    }
    
    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  void _handleMenuAction(String action, Map<String, dynamic> listing) {
    switch (action) {
      case 'edit':
        context.push('/my-listings/edit/${listing['id']}');
        break;
      case 'delete':
        _showDeleteDialog(listing);
        break;
    }
  }

  void _showDeleteDialog(Map<String, dynamic> listing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Listing'),
        content: Text('Are you sure you want to delete the listing for ${listing['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement delete functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${listing['name']} listing deleted'),
                ),
              );
            },
            child: const Text(AppStrings.delete),
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
      default:
        return AppColors.otherPetColor;
    }
  }

  List<Map<String, dynamic>> _getMockListings() {
    return [
      {
        'id': '1',
        'name': 'Buddy',
        'species': 'Dog',
        'breed': 'Golden Retriever',
        'status': 'Available',
      },
      {
        'id': '2',
        'name': 'Whiskers',
        'species': 'Cat',
        'breed': 'Siamese',
        'status': 'Pending',
      },
    ];
  }
} 