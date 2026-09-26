import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'app/constants/app_constants.dart';
import 'app/theme/app_theme.dart';
import 'providers/passport_provider.dart';
import 'providers/favourites_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/catering_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/passport_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/dish_detail_screen.dart';
import 'screens/ingredient_detail_screen.dart';
import 'screens/bar_screen.dart';
import 'screens/catering_screen.dart';
import 'screens/events_screen.dart';
import 'screens/story_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/favourites_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KhaarApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/passport',
      builder: (context, state) => const PassportScreen(),
      routes: [
        GoRoute(
          path: ':regionId',
          builder: (context, state) {
            final regionId = state.pathParameters['regionId'];
            return PassportScreen(initialRegionId: regionId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: '/dish/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return DishDetailScreen(dishId: id);
      },
    ),
    GoRoute(
      path: '/ingredient/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return IngredientDetailScreen(ingredientId: id);
      },
    ),
    GoRoute(
      path: '/bar',
      builder: (context, state) => const BarScreen(),
    ),
    GoRoute(
      path: '/catering',
      builder: (context, state) => const CateringScreen(),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: '/story',
      builder: (context, state) => const StoryScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => const FavouritesScreen(),
    ),
  ],
);

class KhaarApp extends StatelessWidget {
  const KhaarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PassportProvider()),
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CateringProvider()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _router,
      ),
    );
  }
}
