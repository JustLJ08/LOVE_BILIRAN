import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../config/themes/colors.dart';
import '../../../domain/entities/announcement.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/entities/tourist_spot.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/admin/admin_drawer.dart';
import '../../widgets/common/loading_indicator.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.clientHome, (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text("Admin Dashboard"),
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: "Spots"),
              Tab(text: "Events"),
              Tab(text: "Updates"),
              Tab(text: "Contacts"),
            ],
          ),
        ),
        drawer: const AdminDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildStreamList<TouristSpot>(
              stream: context.read<DataBloc>().spotsStream,
              itemBuilder: (item) => ListTile(title: Text(item.name)),
              emptyMessage: "No spots yet.",
            ),
            _buildStreamList<LocalEvent>(
              stream: context.read<DataBloc>().eventsStream,
              itemBuilder: (item) => ListTile(title: Text(item.title)),
              emptyMessage: "No events yet.",
            ),
            _buildStreamList<Announcement>(
              stream: context.read<DataBloc>().announcementsStream,
              itemBuilder: (item) => ListTile(title: Text(item.title)),
              emptyMessage: "No announcements yet.",
            ),
            _buildStreamList<Contact>(
              stream: context.read<DataBloc>().contactsStream,
              itemBuilder: (item) => ListTile(title: Text(item.name)),
              emptyMessage: "No contacts yet.",
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            switch (_tabController.index) {
              case 0:
                Navigator.pushNamed(context, AppRoutes.addSpot);
                break;
              case 1:
                Navigator.pushNamed(context, AppRoutes.addEvent);
                break;
              case 2:
                Navigator.pushNamed(context, AppRoutes.addAnnouncement);
                break;
              case 3:
                Navigator.pushNamed(context, AppRoutes.addContact);
                break;
            }
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildStreamList<T>({
    required Stream<List<T>> stream,
    required Widget Function(T) itemBuilder,
    required String emptyMessage,
  }) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading data"));
        }
        if (!snapshot.hasData) {
          return const LoadingIndicator();
        }
        final list = snapshot.data!;
        if (list.isEmpty) {
          return Center(child: Text(emptyMessage));
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => itemBuilder(list[index]),
        );
      },
    );
  }
}