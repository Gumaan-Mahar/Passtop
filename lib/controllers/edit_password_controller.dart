import 'package:passtop/core/imports/core_imports.dart';

import '../core/imports/packages_imports.dart';

class EditPasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString newPasswordExpiryMonth = ''.obs;
  final RxString newPasswordExpiryYear = ''.obs;

  final TextEditingController newPasswordAppNameController =
      TextEditingController();
  final TextEditingController newPasswordUsernameController =
      TextEditingController();
  final TextEditingController newPasswordPasswordController =
      TextEditingController();
  final TextEditingController newPasswordWebsiteUrlController =
      TextEditingController();
  final TextEditingController newPasswordCardNumberController =
      TextEditingController();
  final TextEditingController newPasswordNameOnCardController =
      TextEditingController();
  final TextEditingController newPasswordNicknameController =
      TextEditingController();
  final TextEditingController newPasswordFirstNameController =
      TextEditingController();
  final TextEditingController newPasswordLastNameController =
      TextEditingController();
  final TextEditingController newPasswordIdentityNumberController =
      TextEditingController();
  final TextEditingController newPasswordAddressNameController =
      TextEditingController();
  final TextEditingController newPasswordAddressOrganisationController =
      TextEditingController();
  final TextEditingController newPasswordAddressPhoneController =
      TextEditingController();
  final TextEditingController newPasswordAddressEmailController =
      TextEditingController();
  final TextEditingController newPasswordAddressRegionController =
      TextEditingController();
  final TextEditingController newPasswordAddressStreetAddressController =
      TextEditingController();
  final TextEditingController newPasswordAddressCityController =
      TextEditingController();
  final TextEditingController newPasswordAddressPostalCodeController =
      TextEditingController();
  final TextEditingController newPasswordGeneralTextController =
      TextEditingController();
  final TextEditingController newPasswordNotesController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    newPasswordAppNameController.dispose();
    newPasswordUsernameController.dispose();
    newPasswordPasswordController.dispose();
    newPasswordWebsiteUrlController.dispose();
    newPasswordCardNumberController.dispose();
    newPasswordNameOnCardController.dispose();
    newPasswordNicknameController.dispose();
    newPasswordFirstNameController.dispose();
    newPasswordLastNameController.dispose();
    newPasswordIdentityNumberController.dispose();
    newPasswordAddressNameController.dispose();
    newPasswordAddressOrganisationController.dispose();
    newPasswordAddressPhoneController.dispose();
    newPasswordAddressEmailController.dispose();
    newPasswordAddressRegionController.dispose();
    newPasswordAddressStreetAddressController.dispose();
    newPasswordAddressCityController.dispose();
    newPasswordAddressPostalCodeController.dispose();
    newPasswordGeneralTextController.dispose();
    newPasswordNotesController.dispose();
  }
}
