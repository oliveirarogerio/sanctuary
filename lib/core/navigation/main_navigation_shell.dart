import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';

/// Main navigation shell with bottom navigation bar
class MainNavigationShell extends StatelessWidget {
  final Widget child;

  const MainNavigationShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark ? AppColors.glassGradientDark : AppColors.glassGradient,
            ),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? AppColors.glassBorderDark.withOpacity(0.3)
                    : AppColors.separator,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.secondary.withOpacity(0.1)
                    : AppColors.glassShadow,
                blurRadius: 15,
                offset: const Offset(0, -5),
                spreadRadius: 0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _getCurrentIndex(currentLocation),
            onTap: (index) => _onTabTapped(context, index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pets_outlined),
                activeIcon: Icon(Icons.pets),
                label: AppStrings.browse,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                activeIcon: Icon(Icons.list_alt),
                label: AppStrings.myListings,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                activeIcon: Icon(Icons.favorite),
                label: AppStrings.favorites,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: AppStrings.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    
    // Only show FAB on My Listings tab
    if (currentLocation.startsWith('/my-listings')) {
      return FloatingActionButton(
        onPressed: () => context.push('/my-listings/create'),
        tooltip: AppStrings.addPet,
        child: const Icon(Icons.add),
      );
    }
    
    return null;
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/browse')) return 0;
    if (location.startsWith('/my-listings')) return 1;
    if (location.startsWith('/favorites')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // Default to browse
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/browse');
        break;
      case 1:
        context.go('/my-listings');
        break;
      case 2:
        context.go('/favorites');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}