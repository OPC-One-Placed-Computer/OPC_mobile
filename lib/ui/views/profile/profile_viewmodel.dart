import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/update_user.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfileViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService;
  final ImagePicker _picker = ImagePicker();

  ProfileViewModel({required ApiServiceService apiService})
      : _apiService = apiService;

  String? firstName;
  String? lastName;
  String? email;
  String? address;
  int? userId;
  String? imageName;
  String? imagePath;
  String? oldPassword;
  String? newPassword;

  Uint8List? _profileImage;
  Uint8List? get profileImage => _profileImage;

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    try {
      setBusy(true);

      final authData = await _apiService.getCurrentAuthentication();
      userId = authData.id;
      firstName = authData.firstName;
      lastName = authData.lastName;
      email = authData.email;
      address = authData.address;
      imageName = authData.imageName;
      imagePath = authData.imagePath;

      if (imagePath != null && imagePath!.isNotEmpty) {
        await displayProfileImage(imagePath!);
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      setError('Error fetching user data: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> saveUserData(
    String newFirstName,
    String newLastName,
    String newEmail,
    String newAddress,
  ) async {
    try {
      setBusy(true);

      Uint8List? imageData;
      if (_profileImage != null) {
        imageData = _profileImage;
      }

      log((imageData == null).toString());
      final updateUser = UpdateUser(
        id: userId,
        firstName: newFirstName,
        lastName: newLastName,
        email: newEmail,
        address: newAddress,
        imageName: imageName ?? '',
        imagePath: imagePath ?? '',
        imageUrl: imageData != null ? base64Encode(imageData) : null,
      );

      final updatedUser = await _apiService.updateUser(updateUser, imageData);

      firstName = updatedUser.firstName;
      lastName = updatedUser.lastName;
      email = updatedUser.email;
      address = updatedUser.address;
      imageName = updatedUser.imageName;
      imagePath = updatedUser.imagePath;

      notifyListeners();
    } catch (e) {
      print('Error saving user data: $e');
      setError('Error saving user data: $e');
    } finally {
      setBusy(false);
      toggleEditing();
    }
  }

  Future<void> changePassword(
    String newOldPassword,
    String newNewPassword,
    String newNewPasswordConfirmation,
    String firstName,
    String lastName,
    String email,
    String address,
  ) async {
    try {
      setBusy(true);

      final changePass = UpdatePassword(
        id: userId,
        oldPassword: newOldPassword,
        newPassword: newNewPassword,
        newPasswordConfirmation: newNewPasswordConfirmation,
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
      );

      final changedPass = await _apiService.updatePassword(changePass);

      this.firstName = changedPass.firstName;
      this.lastName = changedPass.lastName;
      this.email = changedPass.email;
      this.address = changedPass.address;
      oldPassword = changedPass.oldPassword;
      newPassword = changedPass.newPassword;
    } catch (e) {
      print('Error changing password: $e');
      setError('Error changing password: $e');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      setBusy(true);

      final pickedFile = await _picker.pickImage(
          source: source, preferredCameraDevice: CameraDevice.front);

      if (pickedFile != null) {
        imageName = path.basename(pickedFile.path);
        _profileImage = await pickedFile.readAsBytes();
        notifyListeners();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
      setError('Error picking image: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> displayProfileImage(String path) async {
    try {
      setBusy(true);
      final downloadedImage = await _apiService.retrieveProfileImage(path);
      _profileImage = downloadedImage;
      notifyListeners();
    } catch (e) {
      print('Error downloading profile image: $e');
    } finally {
      setBusy(false);
    }
  }
}
