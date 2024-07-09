import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: model.hasError
                      ? Center(
                          child: Text(
                            'An error occurred. Please try again.',
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Center(
                              child: Stack(
                                children: [
                                  const CircleAvatar(
                                    radius: 70, // Increased radius
                                    child: Icon(
                                      Icons.person,
                                      size: 90,
                                    ),
                                  ),
                                  if (model.isEditing)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 20,
                                        child: IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Profile Information',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: AbsorbPointer(
                                absorbing: !model.isEditing,
                                child: TextFormField(
                                  controller: fullNameController,
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    labelStyle: GoogleFonts.poppins(),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: AbsorbPointer(
                                absorbing: !model.isEditing,
                                child: TextFormField(
                                  controller: emailController,
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.poppins(),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: AbsorbPointer(
                                absorbing: !model.isEditing,
                                child: TextFormField(
                                  controller: addressController,
                                  style: GoogleFonts.poppins(),
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle: GoogleFonts.poppins(),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: !model.isEditing,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: model.isEditing
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            List<String> names =
                                                fullNameController.text
                                                    .split(' ');
                                            String firstName = names.isNotEmpty
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
                                          child: Text(
                                            'Save',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            model.toggleEditing();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        model.toggleEditing();
                                      },
                                      child: Text(
                                        'Edit',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                ),
        );
      },
    );
  }
}
