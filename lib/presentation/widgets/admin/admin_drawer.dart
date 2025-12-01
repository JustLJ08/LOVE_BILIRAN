import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colors.dart';
import '../../blocs/auth/auth_bloc.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.admin_panel_settings,
                    size: 50, color: Colors.white),
                const SizedBox(height: 10),
                Text("Admin Menu",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("Manage content",
                    style: GoogleFonts.poppins(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: Text("Logout",
                style: GoogleFonts.poppins(color: AppColors.error)),
            onTap: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
          ),
        ],
      ),
    );
  }
}