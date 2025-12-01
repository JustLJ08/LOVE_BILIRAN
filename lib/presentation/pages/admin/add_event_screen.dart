import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../config/themes/colors.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/common/loading_indicator.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
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
                    controller: _titleCtrl,
                    label: "Event Title",
                    icon: Icons.event,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: AppColors.primary),
                          const SizedBox(width: 12),
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : DateFormat.yMMMd().format(_selectedDate!),
                            style: TextStyle(
                              color: _selectedDate == null
                                  ? Colors.grey.shade600
                                  : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_selectedDate == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12),
                      child: Text("Date is required",
                          style: TextStyle(color: AppColors.error, fontSize: 12)),
                    ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _locationCtrl,
                    label: "Location",
                    icon: Icons.location_on,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Save Event",
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        context.read<DataBloc>().add(AddEventSubmitted(
                              title: _titleCtrl.text,
                              date: _selectedDate!,
                              location: _locationCtrl.text,
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