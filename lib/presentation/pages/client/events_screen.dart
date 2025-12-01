import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colors.dart';
import '../../../domain/entities/event.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/client/event_card.dart';
import '../../widgets/common/loading_indicator.dart';

class EventsScreen extends StatelessWidget {
  final DataBloc dataBloc;
  const EventsScreen({super.key, required this.dataBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Upcoming Events"),
      ),
      body: StreamBuilder<List<LocalEvent>>(
        stream: dataBloc.eventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child:
                    Text("Error loading events", style: GoogleFonts.poppins()));
          }
          if (!snapshot.hasData) {
            return const LoadingIndicator();
          }
          final events = snapshot.data!;
          if (events.isEmpty) {
            return const Center(child: Text("No upcoming events."));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            },
          );
        },
      ),
    );
  }
}