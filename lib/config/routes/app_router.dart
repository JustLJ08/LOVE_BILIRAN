import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/data/data_bloc.dart';
import '../../presentation/pages/admin/add_announcement_screen.dart';
import '../../presentation/pages/admin/add_contact_screen.dart';
import '../../presentation/pages/admin/add_event_screen.dart';
import '../../presentation/pages/admin/add_spot_screen.dart';
import '../../presentation/pages/admin/admin_dashboard.dart';
import '../../presentation/pages/admin/admin_login_screen.dart';
import '../../presentation/pages/client/client_main_nav.dart';
import '../../presentation/pages/splash/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
 return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.clientHome:
        return MaterialPageRoute(
 builder: (_) => BlocProvider(
            create: (_) => sl<DataBloc>(),
            child: const ClientMainNav(),
          ),
        );
      case AppRoutes.adminLogin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const AdminLoginScreen(),
          ),
        );
      case AppRoutes.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<AuthBloc>()),
              BlocProvider(create: (_) => sl<DataBloc>()),
            ],
            child: const AdminDashboard(),
          ),
        );
      case AppRoutes.addSpot:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DataBloc>(),
            child: const AddSpotScreen(),
          ),
        );
      case AppRoutes.addEvent:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DataBloc>(),
            child: const AddEventScreen(),
          ),
        );
      case AppRoutes.addAnnouncement:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DataBloc>(),
            child: const AddAnnouncementScreen(),
          ),
        );
      case AppRoutes.addContact:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<DataBloc>(),
            child: const AddContactScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}