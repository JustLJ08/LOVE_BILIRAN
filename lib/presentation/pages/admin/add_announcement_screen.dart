import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/themes/colors.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/data/data_bloc.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/common/loading_indicator.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Announcement")),
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
                    label: "Title",
                    icon: Icons.title,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _messageCtrl,
                    label: "Message",
                    icon: Icons.message,
                    maxLines: 5,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: "Post Announcement",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<DataBloc>().add(AddAnnouncementSubmitted(
                              title: _titleCtrl.text,
                              message: _messageCtrl.text,
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