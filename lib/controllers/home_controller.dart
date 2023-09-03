import 'package:passtop/controllers/initialization_controller.dart';
import 'package:passtop/core/imports/core_imports.dart';
import 'package:passtop/models/password.dart';
import 'package:passtop/services/passwords_services.dart';

import '../core/imports/packages_imports.dart';
import '../core/instances.dart';

class HomeController extends GetxController {
  RxList passwords = [].obs;
  RxList recentPasswords = [].obs;
  final List<String> categories = [
    'App',
    'Browser',
    'Payment',
    'Identity',
    'Address',
    'General',
  ];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ScrollController passwordsScrollController = ScrollController();

  RxBool isPasswordsFetching = false.obs;
  RxBool hasPasswordsFetchError = false.obs;
  RxBool isRetryingPasswordsFetch = false.obs;
  RxString passwordsFetchErrorMessage = ''.obs;
  RxInt appsPasswordsTotal = 0.obs;
  RxInt browsersPasswordsTotal = 0.obs;
  RxInt paymentsPasswordsTotal = 0.obs;
  RxInt identitiesPasswordsTotal = 0.obs;
  RxInt addressesPasswordsTotal = 0.obs;
  RxInt generalPasswordsTotal = 0.obs;

  final InitializationController initializationController = Get.find();

  RxBool isAppBarCollapsed = false.obs;

  @override
  void onInit() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser != null) {
      isPasswordsFetching.value = true;
      passwords.value = await PasswordsServices.fetchPasswords(
        userId: currentUser.id,
        encryptionKey: initializationController.encryptionKey.value!,
        hasPasswordsFetchError: hasPasswordsFetchError,
        isRetryingPasswordsFetch: isRetryingPasswordsFetch,
        passwordsFetchErrorMessage: passwordsFetchErrorMessage,
      );
      isPasswordsFetching.value = false;
      if (passwords.isNotEmpty) {
        appsPasswordsTotal.value = passwords
            .where((password) => password.category == categories[0])
            .length;
        browsersPasswordsTotal.value = passwords
            .where((password) => password.category == categories[1])
            .length;
        paymentsPasswordsTotal.value = passwords
            .where((password) => password.category == categories[2])
            .length;
        identitiesPasswordsTotal.value = passwords
            .where((password) => password.category == categories[3])
            .length;
        addressesPasswordsTotal.value = passwords
            .where((password) => password.category == categories[4])
            .length;
        generalPasswordsTotal.value = passwords
            .where((password) => password.category == categories[5])
            .length;
      }
      PasswordsServices.subscribeToPasswordsChannel(
        passwords: passwords,
        homeController: this,
      );
      refreshRecentPasswords(
        recentPasswordsList: recentPasswords,
        passwordsList: passwords,
      );
    }
    super.onInit();
  }

  void refreshRecentPasswords(
      {required RxList recentPasswordsList, required RxList passwordsList}) {
    recentPasswordsList.value = passwordsList.where(
      (password) {
        final createdAt = password.createdAt;
        final fromDate = DateTime.now().subtract(const Duration(days: 1));
        return createdAt.isAfter(
          fromDate,
        );
      },
    ).toList();
    recentPasswordsList.sort(
      (first, second) {
        final firstCreatedAt = first.createdAt;
        final secondCreatedAt = second.createdAt;
        return secondCreatedAt.compareTo(firstCreatedAt);
      },
    );
  }

  void updatePasswordListEdit(PasswordModel updatedPassword) {
    passwords.removeWhere((password) => password.id == updatedPassword.id);
    passwords.add(updatedPassword);
    refreshRecentPasswords(
      recentPasswordsList: recentPasswords,
      passwordsList: passwords,
    );
  }

  void updatePasswordListAfterDelete(String passwordID) {
    passwords.removeWhere((element) => element.id == passwordID);
  }

  Future<void> handleAddNewPassword() async {
    await EasyLoading.show(status: 'Saving...');
    final randomId = uuid.v4();
    final PasswordModel password = PasswordModel(
      id: randomId,
      userId: supabase.auth.currentUser!.id,
      createdAt: DateTime.now(),
      category: newPasswordSelectedCategory.value,
      appName: newPasswordAppNameController.text,
      username: newPasswordUsernameController.text,
      password: newPasswordPasswordController.text,
      websiteUrl: newPasswordWebsiteUrlController.text,
      cardNumber: newPasswordCardNumberController.text,
      nameOnCard: newPasswordNameOnCardController.text,
      expiryMonth: newPasswordExpiryMonth.value,
      expiryYear: newPasswordExpiryYear.value,
      nickName: newPasswordNicknameController.text,
      firstName: newPasswordFirstNameController.text,
      lastName: newPasswordLastNameController.text,
      identityNumber: newPasswordIdentityNumberController.text,
      addressName: newPasswordAddressNameController.text,
      addressOrganisation: newPasswordAddressOrganisationController.text,
      addressPhone: newPasswordAddressPhoneController.text,
      addressEmail: newPasswordAddressEmailController.text,
      addressRegion: newPasswordAddressRegionController.text,
      addressStreetAddress: newPasswordAddressStreetAddressController.text,
      addressCity: newPasswordAddressCityController.text,
      addressPostalCode: newPasswordAddressPostalCodeController.text,
      generalText: newPasswordGeneralTextController.text,
      notes: newPasswordNotesController.text,
    );
    await PasswordsServices.savePassword(
        password: password,
        encryptionKey: initializationController.encryptionKey.value!);
    newPasswordSelectedCategory.value = categories[0];
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    clearTextFields();
    await EasyLoading.dismiss();
  }

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
  final FocusNode newPasswordLastNameFocus = FocusNode();
  final FocusNode newPasswordIdentityNumberFocus = FocusNode();
  final FocusNode newPasswordAddressNameFocus = FocusNode();
  final FocusNode newPasswordAddressOrganisationFocus = FocusNode();
  final FocusNode newPasswordAddressPhoneFocus = FocusNode();
  final FocusNode newPasswordAddressEmailFocus = FocusNode();
  final FocusNode newPasswordAddressRegionFocus = FocusNode();
  final FocusNode newPasswordAddressStreetAddressFocus = FocusNode();
  final FocusNode newPasswordAddressCityFocus = FocusNode();
  final FocusNode newPasswordAddressPostalCodeFocus = FocusNode();
  final FocusNode newPasswordGeneralTextFocus = FocusNode();

  void clearTextFields() {
    Get.back();
    newPasswordAppNameController.clear();
    newPasswordUsernameController.clear();
    newPasswordPasswordController.clear();
    newPasswordWebsiteUrlController.clear();
    newPasswordCardNumberController.clear();
    newPasswordNameOnCardController.clear();
    newPasswordNicknameController.clear();
    newPasswordFirstNameController.clear();
    newPasswordLastNameController.clear();
    newPasswordIdentityNumberController.clear();
    newPasswordAddressNameController.clear();
    newPasswordAddressOrganisationController.clear();
    newPasswordAddressPhoneController.clear();
    newPasswordAddressEmailController.clear();
    newPasswordAddressRegionController.clear();
    newPasswordAddressStreetAddressController.clear();
    newPasswordAddressCityController.clear();
    newPasswordAddressPostalCodeController.clear();
    newPasswordGeneralTextController.clear();
    newPasswordNotesController.clear();
  }

  void clearCategoryPasswordsQuantities() {
    appsPasswordsTotal.value = 0;
    browsersPasswordsTotal.value = 0;
    paymentsPasswordsTotal.value = 0;
    identitiesPasswordsTotal.value = 0;
    addressesPasswordsTotal.value = 0;
    generalPasswordsTotal.value = 0;
  }

  @override
  void dispose() async {
    PasswordsServices.unsubscribeFromPasswordsChannel();
    passwordsScrollController.dispose();
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

    newPasswordAppNameFocus.dispose();
    newPasswordUsernameFocus.dispose();
    newPasswordPasswordFocus.dispose();
    newPasswordWebsiteUrlFocus.dispose();
    newPasswordCardNumberFocus.dispose();
    newPasswordNameOnCardFocus.dispose();
    newPasswordNicknameFocus.dispose();
    newPasswordFirstNameFocus.dispose();
    newPasswordLastNameFocus.dispose();
    newPasswordIdentityNumberFocus.dispose();
    newPasswordAddressNameFocus.dispose();
    newPasswordAddressOrganisationFocus.dispose();
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
