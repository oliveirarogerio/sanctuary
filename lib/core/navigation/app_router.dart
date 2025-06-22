import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/register_screen.dart';
import '../../features/authentication/screens/splash_screen.dart';
import '../../features/pets/screens/browse_pets_screen.dart';
import '../../features/pets/screens/pet_details_screen.dart';
import '../../features/pets/screens/create_listing_screen.dart';
import '../../features/pets/screens/my_listings_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/favorites_screen.dart';
import '../../features/applications/screens/my_applications_screen.dart';
import '../../features/applications/screens/application_details_screen.dart';
import '../constants/app_strings.dart';
import 'main_navigation_shell.dart';

/// App router configuration using go_router
class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String browse = '/browse';
  static const String petDetails = '/pet/:petId';
  static const String createListing = '/create-listing';
  static const String myListings = '/my-listings';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String myApplications = '/my-applications';
  static const String applicationDetails = '/application/:applicationId';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash screen
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Authentication routes
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Pet details - MOVED OUTSIDE shell for full-screen view
      GoRoute(
        path: '/browse/pet/:petId',
        name: 'petDetails',
        builder: (context, state) {
          final petId = state.pathParameters['petId']!;
          return const PetDetailsScreen();
        },
      ),
      
      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigationShell(child: child),
        routes: [
          // Browse pets tab
          GoRoute(
            path: browse,
            name: 'browse',
            builder: (context, state) => const BrowsePetsScreen(),
          ),
          
          // My listings tab
          GoRoute(
            path: myListings,
            name: 'myListings',
            builder: (context, state) => const MyListingsScreen(),
            routes: [
              // Create new listing
              GoRoute(
                path: 'create',
                name: 'createListing',
                builder: (context, state) => const CreateListingScreen(),
              ),
              // Edit existing listing
              GoRoute(
                path: 'edit/:petId',
                name: 'editListing',
                builder: (context, state) {
                  final petId = state.pathParameters['petId']!;
                  return CreateListingScreen(petId: petId);
                },
              ),
            ],
          ),
          
          // Favorites tab
          GoRoute(
            path: favorites,
            name: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          
          // Profile tab
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              // My applications
              GoRoute(
                path: 'applications',
                name: 'myApplications',
                builder: (context, state) => const MyApplicationsScreen(),
                routes: [
                  // Application details
                  GoRoute(
                    path: ':applicationId',
                    name: 'applicationDetails',
                    builder: (context, state) {
                      final applicationId = state.pathParameters['applicationId']!;
                      return ApplicationDetailsScreen(applicationId: applicationId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(browse),
              child: const Text('Go to Browse'),
            ),
          ],
        ),
      ),
    ),
  );
} 