import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Screen for creating and editing pet listings
class CreateListingScreen extends StatefulWidget {
  final String? petId; // If provided, we're editing an existing listing
  
  const CreateListingScreen({
    super.key,
    this.petId,
  });

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedSpecies = 'Dog';
  String _selectedGender = 'Male';
  String _selectedSize = 'Medium';
  bool _isLoading = false;

  bool get _isEditing => widget.petId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? AppStrings.editPet : AppStrings.addPet),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveListing,
            child: const Text(AppStrings.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo upload section
              _buildPhotoSection(),
              const SizedBox(height: AppDimensions.spaceLarge),
              
              // Basic info
              _buildBasicInfo(),
              const SizedBox(height: AppDimensions.spaceLarge),
              
              // Description
              _buildDescription(),
              const SizedBox(height: AppDimensions.spaceXLarge),
              
              // Save button
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.addPhotos,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppDimensions.spaceMedium),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            border: Border.all(
              color: AppColors.textLight,
              style: BorderStyle.solid,
            ),
          ),
          child: InkWell(
            onTap: _pickImages,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_a_photo,
                  size: AppDimensions.iconLarge,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: AppDimensions.spaceMedium),
                Text(
                  'Tap to add photos',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pet Information',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppDimensions.spaceLarge),
        
        // Pet name
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: AppStrings.petName,
            prefixIcon: Icon(Icons.pets),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter pet name';
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimensions.spaceLarge),
        
        // Species dropdown
        DropdownButtonFormField<String>(
          value: _selectedSpecies,
          decoration: const InputDecoration(
            labelText: AppStrings.species,
            prefixIcon: Icon(Icons.category),
          ),
          items: const [
            DropdownMenuItem(value: 'Dog', child: Text(AppStrings.dog)),
            DropdownMenuItem(value: 'Cat', child: Text(AppStrings.cat)),
            DropdownMenuItem(value: 'Bird', child: Text(AppStrings.bird)),
            DropdownMenuItem(value: 'Rabbit', child: Text(AppStrings.rabbit)),
            DropdownMenuItem(value: 'Other', child: Text(AppStrings.other)),
          ],
          onChanged: (value) {
            setState(() {
              _selectedSpecies = value!;
            });
          },
        ),
        const SizedBox(height: AppDimensions.spaceLarge),
        
        // Breed and age row
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  labelText: AppStrings.breed,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMedium),
            Expanded(
              child: TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: AppStrings.age,
                  suffixText: 'years',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceLarge),
        
        // Gender and size row
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: AppStrings.gender,
                ),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text(AppStrings.male)),
                  DropdownMenuItem(value: 'Female', child: Text(AppStrings.female)),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMedium),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedSize,
                decoration: const InputDecoration(
                  labelText: AppStrings.size,
                ),
                items: const [
                  DropdownMenuItem(value: 'Small', child: Text(AppStrings.small)),
                  DropdownMenuItem(value: 'Medium', child: Text(AppStrings.medium)),
                  DropdownMenuItem(value: 'Large', child: Text(AppStrings.large)),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedSize = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.description,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppDimensions.spaceMedium),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: 'Tell us about this pet\'s personality, behavior, and what makes them special...',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveListing,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(_isEditing ? 'Update Listing' : 'Create Listing'),
      ),
    );
  }

  void _pickImages() {
    // TODO: Implement image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker coming soon!'),
      ),
    );
  }

  Future<void> _saveListing() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement Firebase save
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Listing updated successfully!' : 'Listing created successfully!',
          ),
        ),
      );
      context.pop();
    }

    setState(() {
      _isLoading = false;
    });
  }
} 