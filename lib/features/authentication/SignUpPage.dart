import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:streamrank/core/network/back-end/AuthApiService.dart';
import 'package:streamrank/core/network/back-end/dto/authentication/UserSignUpDTO.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthApiService authApiService = AuthApiService();

  SignUpPage({super.key});

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      try {
        final signUpDTO = UserSignUpDTO.fromFormData(formData!);

        final response = await authApiService.signUp(signUpDTO);

        if (response["status"] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-up successful!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-up failed!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Internal Server Error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Rank Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // First Name
                FormBuilderTextField(
                  name: 'firstName',
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Last Name
                FormBuilderTextField(
                  name: 'lastName',
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Email
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                    FormBuilderValidators.email(
                        errorText: 'Invalid email address'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Username
                FormBuilderTextField(
                  name: 'userName',
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Password
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                    FormBuilderValidators.minLength(8,
                        errorText: 'Minimum 8 characters required'),
                    FormBuilderValidators.maxLength(20,
                        errorText: 'Maximum 20 characters allowed'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Date of Birth
                FormBuilderDateTimePicker(
                  name: 'dateOfBirth',
                  inputType: InputType.date,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  format: DateFormat('yyyy-MM-dd'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Field must not be empty'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
