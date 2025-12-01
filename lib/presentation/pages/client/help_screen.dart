import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colors.dart';
import '../../../domain/entities/contact.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/client/contact_card.dart';
import '../../widgets/common/loading_indicator.dart';

class HelpScreen extends StatelessWidget {
  final DataBloc dataBloc;
  const HelpScreen({super.key, required this.dataBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Emergency Contacts"),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: dataBloc.contactsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Error loading contacts",
                    style: GoogleFonts.poppins()));
          }
          if (!snapshot.hasData) {
            return const LoadingIndicator();
          }
          final contacts = snapshot.data!;
          if (contacts.isEmpty) {
            return const Center(child: Text("No contacts available."));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ContactCard(contact: contacts[index]);
            },
          );
        },
      ),
    );
  }
}