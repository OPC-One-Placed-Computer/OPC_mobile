import 'package:flutter/material.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/ui/views/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(apiService: ApiServiceImpl()),
      onViewModelReady: (model) => model.fetchUserData(),
      builder: (context, model, child) {
        final fullNameController = TextEditingController(text: model.fullName);
        final emailController = TextEditingController(text: model.email);
        final addressController = TextEditingController(text: model.address);

        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: model.isBusy
                  ? const CircularProgressIndicator()
                  : model.hasError
                      ? const Text('An error occurred. Please try again.')
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50), // Space from top
                              // Circular icon for profile image
                              const CircleAvatar(
                                radius: 50,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(height: 16), // Add some space
                              Container(
                                height: 50, // Adjust the height as needed
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  controller: fullNameController,
                                  style: const TextStyle(
                                      fontSize:
                                          16), // Adjust font size as needed
                                  decoration: const InputDecoration(
                                    labelText: 'Full Name',
                                    labelStyle: TextStyle(
                                        fontSize: 16), // Adjust label font size
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 50, // Adjust the height as needed
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  style: const TextStyle(
                                      fontSize:
                                          16), // Adjust font size as needed
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        fontSize: 16), // Adjust label font size
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 50, // Adjust the height as needed
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  controller: addressController,
                                  style: const TextStyle(
                                      fontSize:
                                          16), // Adjust font size as needed
                                  decoration: const InputDecoration(
                                    labelText: 'Address',
                                    labelStyle: TextStyle(
                                        fontSize: 16), // Adjust label font size
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                              const SizedBox(height: 16), // Add some space
                              // Edit button
                              model.isEditing
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Split full name into first and last name
                                            List<String> names =
                                                fullNameController.text
                                                    .split(' ');
                                            String firstName = names.length > 0
                                                ? names[0]
                                                : '';
                                            String lastName = names.length > 1
                                                ? names[1]
                                                : '';

                                            model.saveUserData(
                                              firstName,
                                              lastName,
                                              emailController.text,
                                              addressController.text,
                                            );
                                          },
                                          child: const Text('Save'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            model.toggleEditing();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        model.toggleEditing();
                                      },
                                      child: const Text('Edit'),
                                    ),
                            ],
                          ),
                        ),
            ),
          ),
        );
      },
    );
  }
}
