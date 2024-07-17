import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: model.profileImage != null
                                  ? MemoryImage(model.profileImage!)
                                  : null,
                              child: model.profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 90,
                                    )
                                  : null,
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
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => BottomSheet(
                                          onClosing: () {},
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.camera),
                                                title:
                                                    const Text('Capture Image'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  model.pickImage(
                                                      ImageSource.camera);
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.image),
                                                title: const Text(
                                                    'Pick from Gallery'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  model.pickImage(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
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
                        child: Column(
                          children: [
                            model.isEditing
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          List<String> names =
                                              fullNameController.text
                                                  .split(' ');
                                          String firstName =
                                              names.isNotEmpty ? names[0] : '';
                                          String lastName =
                                              names.length > 1 ? names[1] : '';

                                          await model
                                              .saveUserData(
                                            firstName,
                                            lastName,
                                            emailController.text,
                                            addressController.text,
                                          )
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Profile updated successfully',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            model.fetchUserData();
                                          }).catchError((error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Error saving user data: $error',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          });
                                        },
                                        icon: Icon(Icons.save),
                                        label: Text(
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
                                : ElevatedButton.icon(
                                    onPressed: () {
                                      model.toggleEditing();
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text(
                                      'Edit',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                final oldPasswordController =
                                    TextEditingController();
                                final newPasswordController =
                                    TextEditingController();
                                final confirmPasswordController =
                                    TextEditingController();

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Change Password',
                                          style: GoogleFonts.poppins()),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: oldPasswordController,
                                            decoration: InputDecoration(
                                              labelText: 'Old Password',
                                              labelStyle: GoogleFonts.poppins(),
                                            ),
                                            obscureText: true,
                                          ),
                                          const SizedBox(height: 8),
                                          TextFormField(
                                            controller: newPasswordController,
                                            decoration: InputDecoration(
                                              labelText: 'New Password',
                                              labelStyle: GoogleFonts.poppins(),
                                            ),
                                            obscureText: true,
                                          ),
                                          const SizedBox(height: 8),
                                          TextFormField(
                                            controller:
                                                confirmPasswordController,
                                            decoration: InputDecoration(
                                              labelText: 'Confirm Password',
                                              labelStyle: GoogleFonts.poppins(),
                                            ),
                                            obscureText: true,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel',
                                              style: GoogleFonts.poppins()),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (newPasswordController.text
                                                    .trim() ==
                                                confirmPasswordController.text
                                                    .trim()) {
                                              List<String> names =
                                                  fullNameController.text
                                                      .split(' ');
                                              String firstName =
                                                  names.isNotEmpty
                                                      ? names[0]
                                                      : '';
                                              String lastName = names.length > 1
                                                  ? names[1]
                                                  : '';

                                              model
                                                  .changePassword(
                                                oldPasswordController.text,
                                                newPasswordController.text,
                                                confirmPasswordController.text,
                                                firstName,
                                                lastName,
                                                emailController.text,
                                                addressController.text,
                                              )
                                                  .then((value) {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Password changed successfully',
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }).catchError((error) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Error changing password: $error',
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Passwords do not match',
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Change Password',
                                              style: GoogleFonts.poppins()),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.lock),
                              label: Text(
                                'Change Password',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
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
