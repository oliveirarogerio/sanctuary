import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Screen displaying details of a specific adoption application
class ApplicationDetailsScreen extends StatelessWidget {
  final String applicationId;
  
  const ApplicationDetailsScreen({
    super.key,
    required this.applicationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            const Text(
              'Application Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Application ID: $applicationId',
              style: const TextStyle(
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming Soon!',
              style: TextStyle(
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 