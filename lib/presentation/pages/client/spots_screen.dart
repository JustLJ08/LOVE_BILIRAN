import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colors.dart';
import '../../../domain/entities/tourist_spot.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/client/spot_card.dart';
import '../../widgets/common/loading_indicator.dart';

class SpotsScreen extends StatelessWidget {
  final DataBloc dataBloc;
  const SpotsScreen({super.key, required this.dataBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Top Destinations"),
      ),
      body: StreamBuilder<List<TouristSpot>>(
        stream: dataBloc.spotsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Error loading spots", style: GoogleFonts.poppins()));
          }
          if (!snapshot.hasData) {
            return const LoadingIndicator();
          }
          final allSpots = snapshot.data!;
          if (allSpots.isEmpty) {
            return const Center(child: Text("No destinations added yet."));
          }
          return _SearchableSpotsList(allSpots: allSpots);
        },
      ),
    );
  }
}

class _SearchableSpotsList extends StatefulWidget {
  final List<TouristSpot> allSpots;
  const _SearchableSpotsList({required this.allSpots});

  @override
  State<_SearchableSpotsList> createState() => _SearchableSpotsListState();
}

class _SearchableSpotsListState extends State<_SearchableSpotsList> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() {
        _searchText = _searchCtrl.text;
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSpots = widget.allSpots.where((spot) {
      final nameLower = spot.name.toLowerCase();
      final searchLower = _searchText.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: "Search destinations...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        _searchCtrl.clear();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  : null,
            ),
          ),
        ),
        Expanded(
          child: filteredSpots.isEmpty
              ? Center(
                  child: Text("No results found.",
                      style: GoogleFonts.poppins(color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: filteredSpots.length,
                  itemBuilder: (context, index) {
                    return SpotCard(spot: filteredSpots[index]);
                  },
                ),
        ),
      ],
    );
  }
}