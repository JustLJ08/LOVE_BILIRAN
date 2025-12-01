import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/routes/app_routes.dart';
import '../../../config/themes/colors.dart';
import '../../../domain/entities/announcement.dart';
import '../../../domain/entities/tourist_spot.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/client/announcement_card.dart';
import '../../widgets/common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  final DataBloc dataBloc;
  const HomeScreen({super.key, required this.dataBloc});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(viewportFraction: 0.9);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mabuhay!",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: AppColors.textLight)),
                        const SizedBox(height: 5),
                        Text("Discover Biliran",
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.adminLogin),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.primary, width: 2),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ],
                          // Ensure you have this asset in your new project
                          image: const DecorationImage(
                              image: AssetImage('assets/images/biliran_logo.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Recommended Carousel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Recommended Destinations",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 220,
                child: StreamBuilder<List<TouristSpot>>(
                  stream: dataBloc.spotsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const LoadingIndicator();
                    }
                    final spots = snapshot.data!;
                    return PageView.builder(
                      controller: pageController,
                      itemCount: spots.length,
                      itemBuilder: (context, index) {
                        final spot = spots[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8))
                            ],
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(spot.imageUrl),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.darken),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Top Spot",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(spot.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Announcements
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text("Latest Updates",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.notifications_active,
                        size: 18, color: Colors.orange)
                  ],
                ),
              ),
              const SizedBox(height: 10),

              StreamBuilder<List<Announcement>>(
                stream: dataBloc.announcementsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const LoadingIndicator();
                  }
                  final list = snapshot.data!;
                  if (list.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                          child: Text("No updates today.",
                              style: GoogleFonts.poppins(
                                  color: AppColors.textLight))),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length > 3 ? 3 : list.length,
                    itemBuilder: (context, index) {
                      return AnnouncementCard(announcement: list[index]);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}