import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/themes/colors.dart';
import '../../../core/utils/image_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../injection_container.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/common/loading_indicator.dart';

class AddSpotScreen extends StatefulWidget {
  const AddSpotScreen({super.key});

  @override
  State<AddSpotScreen> createState() => _AddSpotScreenState();
}

class _AddSpotScreenState extends State<AddSpotScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  XFile? _pickedFile;
  Uint8List? _webImage;
  File? _mobileImage;

  Future<void> _pickImage() async {
    final imageHelper = sl<ImageHelper>();
    final result = await imageHelper.pickImage();
    if (result != null) {
      setState(() {
        _pickedFile = result.file;
        _webImage = result.webBytes;
        _mobileImage = result.mobileFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Destination")),
      body: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          if (state is DataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.success));
            Navigator.pop(context);
          }
          if (state is DataError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.error));
          }
        },
        builder: (context, state) {
          if (state is DataLoading) {
            return const LoadingIndicator();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _pickedFile == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const Icon(Icons.add_photo_alternate_rounded,
                                      size: 50, color: AppColors.primary),
                                  Text("Tap to upload photo",
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey))
                                ])
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: kIsWeb
                                  ? Image.memory(_webImage!, fit: BoxFit.cover)
                                  : Image.file(_mobileImage!,
                                      fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    controller: _nameCtrl,
                    label: "Spot Name",
                    icon: Icons.landscape,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _descCtrl,
                    label: "Description",
                    icon: Icons.description,
                    maxLines: 3,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _addressCtrl,
                    label: "Location Address",
                    icon: Icons.location_on,
                    hint: "e.g. Sambawan Island, Maripipi",
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Save Destination",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<DataBloc>().add(AddSpotSubmitted(
                              name: _nameCtrl.text,
                              description: _descCtrl.text,
                              address: _addressCtrl.text,
                              mobileFile: _mobileImage,
                              webBytes: _webImage,
                            ));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}