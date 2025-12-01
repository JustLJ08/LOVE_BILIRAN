import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/themes/colors.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/common/loading_indicator.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  String _selectedType = 'Police';

  final List<String> _contactTypes = [
    'Police',
    'Hospital',
    'Fire Station',
    'Tourism Office',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),
      body: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          if (state is DataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: AppColors.success));
            Navigator.pop(context);
          }
          if (state is DataError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: AppColors.error));
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
                  CustomTextField(
                    controller: _nameCtrl,
                    label: "Contact Name / Office",
                    icon: Icons.badge,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _numberCtrl,
                    label: "Phone Number",
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedType,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: AppColors.primary),
                        items: _contactTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedType = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Save Contact",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<DataBloc>().add(AddContactSubmitted(
                              name: _nameCtrl.text,
                              number: _numberCtrl.text,
                              type: _selectedType,
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