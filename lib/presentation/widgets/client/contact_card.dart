import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/themes/colors.dart';
import '../../../domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  Future<void> _callNumber() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: contact.number,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      debugPrint("Error calling number: $e");
    }
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'police':
        return Icons.local_police;
      case 'hospital':
        return Icons.local_hospital;
      case 'fire station':
        return Icons.fire_truck;
      case 'tourism office':
        return Icons.tour;
      default:
        return Icons.phone;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'police':
        return Colors.blue.shade700;
      case 'hospital':
        return Colors.red.shade700;
      case 'fire station':
        return Colors.orange.shade700;
      case 'tourism office':
        return AppColors.primary;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForType(contact.type);
    final color = _getColorForType(contact.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: _callNumber,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        contact.type,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        contact.number,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.call, color: Colors.green, size: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}