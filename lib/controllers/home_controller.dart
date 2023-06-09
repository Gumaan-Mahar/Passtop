import 'package:passtop/core/imports/core_imports.dart';

import '../core/imports/packages_imports.dart';

class HomeController extends GetxController {
  final List<String> categories = [
    'App',
    'Browser',
    'Payment',
    'Identity',
    'Address',
    'General',
  ];

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  final TextEditingController newPasswordNLastNameController =
      TextEditingController();
  final TextEditingController newPasswordIdentityNumberController =
      TextEditingController();
  final TextEditingController newPasswordAddressNameController =
      TextEditingController();
  final TextEditingController newPasswordAddressOrganizationController =
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

  final RxString newPasswordSelectedCategory = 'App'.obs;
  final RxString newPasswordExpiryMonth = ''.obs;
  final RxString newPasswordExpiryYear = ''.obs;

  final FocusNode newPasswordAppNameFocus = FocusNode();
  final FocusNode newPasswordUsernameFocus = FocusNode();
  final FocusNode newPasswordPasswordFocus = FocusNode();
  final FocusNode newPasswordWebsiteUrlFocus = FocusNode();
  final FocusNode newPasswordCardNumberFocus = FocusNode();
  final FocusNode newPasswordNameOnCardFocus = FocusNode();
  final FocusNode newPasswordNicknameFocus = FocusNode();
  final FocusNode newPasswordFirstNameFocus = FocusNode();
  final FocusNode newPasswordNLastNameFocus = FocusNode();
  final FocusNode newPasswordIdentityNumberFocus = FocusNode();
  final FocusNode newPasswordAddressNameFocus = FocusNode();
  final FocusNode newPasswordAddressOrganizationFocus = FocusNode();
  final FocusNode newPasswordAddressPhoneFocus = FocusNode();
  final FocusNode newPasswordAddressEmailFocus = FocusNode();
  final FocusNode newPasswordAddressRegionFocus = FocusNode();
  final FocusNode newPasswordAddressStreetAddressFocus = FocusNode();
  final FocusNode newPasswordAddressCityFocus = FocusNode();
  final FocusNode newPasswordAddressPostalCodeFocus = FocusNode();
  final FocusNode newPasswordGeneralTextFocus = FocusNode();

  @override
  void dispose() {
    newPasswordAppNameController.dispose();
    newPasswordUsernameController.dispose();
    newPasswordPasswordController.dispose();
    newPasswordWebsiteUrlController.dispose();
    newPasswordCardNumberController.dispose();
    newPasswordNameOnCardController.dispose();
    newPasswordNicknameController.dispose();
    newPasswordFirstNameController.dispose();
    newPasswordNLastNameController.dispose();
    newPasswordIdentityNumberController.dispose();
    newPasswordAddressNameController.dispose();
    newPasswordAddressOrganizationController.dispose();
    newPasswordAddressPhoneController.dispose();
    newPasswordAddressEmailController.dispose();
    newPasswordAddressRegionController.dispose();
    newPasswordAddressStreetAddressController.dispose();
    newPasswordAddressCityController.dispose();
    newPasswordAddressPostalCodeController.dispose();
    newPasswordGeneralTextController.dispose();
    newPasswordNotesController.dispose();

    newPasswordAppNameFocus.dispose();
    newPasswordUsernameFocus.dispose();
    newPasswordPasswordFocus.dispose();
    newPasswordWebsiteUrlFocus.dispose();
    newPasswordCardNumberFocus.dispose();
    newPasswordNameOnCardFocus.dispose();
    newPasswordNicknameFocus.dispose();
    newPasswordFirstNameFocus.dispose();
    newPasswordNLastNameFocus.dispose();
    newPasswordIdentityNumberFocus.dispose();
    newPasswordAddressNameFocus.dispose();
    newPasswordAddressOrganizationFocus.dispose();
    newPasswordAddressPhoneFocus.dispose();
    newPasswordAddressEmailFocus.dispose();
    newPasswordAddressRegionFocus.dispose();
    newPasswordAddressStreetAddressFocus.dispose();
    newPasswordAddressCityFocus.dispose();
    newPasswordAddressPostalCodeFocus.dispose();
    newPasswordGeneralTextFocus.dispose();
    super.dispose();
  }
}
