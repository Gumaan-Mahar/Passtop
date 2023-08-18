import 'dart:typed_data';

import '../core/instances.dart';

class PasswordModel {
  late String id;
  late String userId;
  late DateTime createdAt;
  late String category;
  late String appName;
  late String username;
  late String password;
  late String websiteUrl;
  late String cardNumber;
  late String nameOnCard;
  late String expiryMonth;
  late String expiryYear;
  late String nickName;
  late String firstName;
  late String lastName;
  late String identityNumber;
  late String addressName;
  late String addressOrganisation;
  late String addressPhone;
  late String addressEmail;
  late String addressRegion;
  late String addressStreetAddress;
  late String addressCity;
  late String addressPostalCode;
  late String generalText;
  late String notes;

  PasswordModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.category,
    required this.appName,
    required this.username,
    required this.password,
    required this.websiteUrl,
    required this.cardNumber,
    required this.nameOnCard,
    required this.expiryMonth,
    required this.expiryYear,
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.identityNumber,
    required this.addressName,
    required this.addressOrganisation,
    required this.addressPhone,
    required this.addressEmail,
    required this.addressRegion,
    required this.addressStreetAddress,
    required this.addressCity,
    required this.addressPostalCode,
    required this.generalText,
    required this.notes,
  });

  factory PasswordModel.fromJsonWithDecryption(
      Map<String, dynamic> json, Uint8List encryptionKey) {
    final decryptedData = {
      'id': json['id'],
      'user_id': json['user_id'],
      'created_at': DateTime.parse(json['created_at']),
      'category': json['category'],
      'appName': json['app_name'].isNotEmpty
          ? encryptionServices.decryptData(json['app_name'], encryptionKey)
          : json['app_name'],
      'username': json['username'].isNotEmpty
          ? encryptionServices.decryptData(json['username'], encryptionKey)
          : json['username'],
      'password': json['password'].isNotEmpty
          ? encryptionServices.decryptData(json['password'], encryptionKey)
          : json['password'],
      'websiteUrl': json['website_url'].isNotEmpty
          ? encryptionServices.decryptData(json['website_url'], encryptionKey)
          : json['website_url'],
      'cardNumber': json['card_number'].isNotEmpty
          ? encryptionServices.decryptData(json['card_number'], encryptionKey)
          : json['card_number'],
      'nameOnCard': json['name_on_card'].isNotEmpty
          ? encryptionServices.decryptData(json['name_on_card'], encryptionKey)
          : json['name_on_card'],
      'expiryMonth': json['expiry_month'].isNotEmpty
          ? encryptionServices.decryptData(json['expiry_month'], encryptionKey)
          : json['expiry_month'],
      'expiryYear': json['expiry_year'].isNotEmpty
          ? encryptionServices.decryptData(json['expiry_year'], encryptionKey)
          : json['expiry_year'],
      'nickName': json['nick_name'].isNotEmpty
          ? encryptionServices.decryptData(json['nick_name'], encryptionKey)
          : json['nick_name'],
      'firstName': json['first_name'].isNotEmpty
          ? encryptionServices.decryptData(json['first_name'], encryptionKey)
          : json['first_name'],
      'lastName': json['last_name'].isNotEmpty
          ? encryptionServices.decryptData(json['last_name'], encryptionKey)
          : json['last_name'],
      'identityNumber': json['identity_number'].isNotEmpty
          ? encryptionServices.decryptData(
              json['identity_number'], encryptionKey)
          : json['identity_number'],
      'addressName': json['address_name'].isNotEmpty
          ? encryptionServices.decryptData(json['addressName'], encryptionKey)
          : json['address_name'],
      'addressOrganisation': json['address_organisation'].isNotEmpty
          ? encryptionServices.decryptData(
              json['address_organisation'], encryptionKey)
          : json['address_organisation'],
      'addressPhone': json['address_phone'].isNotEmpty
          ? encryptionServices.decryptData(json['address_phone'], encryptionKey)
          : json['address_phone'],
      'addressEmail': json['address_email'].isNotEmpty
          ? encryptionServices.decryptData(json['address_email'], encryptionKey)
          : json['address_email'],
      'addressRegion': json['address_region'].isNotEmpty
          ? encryptionServices.decryptData(
              json['address_region'], encryptionKey)
          : json['address_region'],
      'addressStreetAddress': json['address_street_address'].isNotEmpty
          ? encryptionServices.decryptData(
              json['address_street_address'], encryptionKey)
          : json['address_street_address'],
      'addressCity': json['address_city'].isNotEmpty
          ? encryptionServices.decryptData(json['address_city'], encryptionKey)
          : json['address_city'],
      'addressPostalCode': json['address_postal_code'].isNotEmpty
          ? encryptionServices.decryptData(
              json['address_postal_code'], encryptionKey)
          : json['address_postal_code'],
      'generalText': json['general_text'].isNotEmpty
          ? encryptionServices.decryptData(json['general_text'], encryptionKey)
          : json['general_text'],
      'notes': json['notes'].isNotEmpty
          ? encryptionServices.decryptData(json['notes'], encryptionKey)
          : json['notes'],
    };
    return PasswordModel(
      id: decryptedData['id'],
      userId: decryptedData['user_id'],
      createdAt: decryptedData['created_at'],
      category: decryptedData['category'],
      appName: decryptedData['appName'],
      username: decryptedData['username'],
      password: decryptedData['password'],
      websiteUrl: decryptedData['websiteUrl'],
      cardNumber: decryptedData['cardNumber'],
      nameOnCard: decryptedData['nameOnCard'],
      expiryMonth: decryptedData['expiryMonth'],
      expiryYear: decryptedData['expiryYear'],
      nickName: decryptedData['nickName'],
      firstName: decryptedData['firstName'],
      lastName: decryptedData['lastName'],
      identityNumber: decryptedData['identityNumber'],
      addressName: decryptedData['addressName'],
      addressOrganisation: decryptedData['addressOrganisation'],
      addressPhone: decryptedData['addressPhone'],
      addressEmail: decryptedData['addressEmail'],
      addressRegion: decryptedData['addressRegion'],
      addressStreetAddress: decryptedData['addressStreetAddress'],
      addressCity: decryptedData['addressCity'],
      addressPostalCode: decryptedData['addressPostalCode'],
      generalText: decryptedData['generalText'],
      notes: decryptedData['notes'],
    );
  }

  Map<String, dynamic> toJsonWithEncryption(Uint8List encryptionKey) {
    final encryptedData = {
      'id': id,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'category': category,
      'app_name': appName.isNotEmpty
          ? encryptionServices.encryptData(appName, encryptionKey)
          : appName,
      'username': username.isNotEmpty
          ? encryptionServices.encryptData(username, encryptionKey)
          : username,
      'password': password.isNotEmpty
          ? encryptionServices.encryptData(password, encryptionKey)
          : password,
      'website_url': websiteUrl.isNotEmpty
          ? encryptionServices.encryptData(websiteUrl, encryptionKey)
          : websiteUrl,
      'card_number': cardNumber.isNotEmpty
          ? encryptionServices.encryptData(cardNumber, encryptionKey)
          : cardNumber,
      'name_on_card': nameOnCard.isNotEmpty
          ? encryptionServices.encryptData(nameOnCard, encryptionKey)
          : nameOnCard,
      'expiry_month': expiryMonth.isNotEmpty
          ? encryptionServices.encryptData(expiryMonth, encryptionKey)
          : expiryMonth,
      'expiry_year': expiryYear.isNotEmpty
          ? encryptionServices.encryptData(expiryYear, encryptionKey)
          : expiryYear,
      'nick_name': nickName.isNotEmpty
          ? encryptionServices.encryptData(nickName, encryptionKey)
          : nickName,
      'first_name': firstName.isNotEmpty
          ? encryptionServices.encryptData(firstName, encryptionKey)
          : firstName,
      'last_name': lastName.isNotEmpty
          ? encryptionServices.encryptData(lastName, encryptionKey)
          : lastName,
      'identity_number': identityNumber.isNotEmpty
          ? encryptionServices.encryptData(identityNumber, encryptionKey)
          : identityNumber,
      'address_name': addressName.isNotEmpty
          ? encryptionServices.encryptData(addressName, encryptionKey)
          : addressName,
      'address_organisation': addressOrganisation.isNotEmpty
          ? encryptionServices.encryptData(addressOrganisation, encryptionKey)
          : addressOrganisation,
      'address_phone': addressPhone.isNotEmpty
          ? encryptionServices.encryptData(addressPhone, encryptionKey)
          : addressPhone,
      'address_email': addressEmail.isNotEmpty
          ? encryptionServices.encryptData(addressEmail, encryptionKey)
          : addressEmail,
      'address_region': addressRegion.isNotEmpty
          ? encryptionServices.encryptData(addressRegion, encryptionKey)
          : addressRegion,
      'address_street_address': addressStreetAddress.isNotEmpty
          ? encryptionServices.encryptData(addressStreetAddress, encryptionKey)
          : addressStreetAddress,
      'address_city': addressCity.isNotEmpty
          ? encryptionServices.encryptData(addressCity, encryptionKey)
          : addressCity,
      'address_postal_code': addressPostalCode.isNotEmpty
          ? encryptionServices.encryptData(addressPostalCode, encryptionKey)
          : addressPostalCode,
      'general_text': generalText.isNotEmpty
          ? encryptionServices.encryptData(generalText, encryptionKey)
          : generalText,
      'notes': notes.isNotEmpty
          ? encryptionServices.encryptData(notes, encryptionKey)
          : notes,
    };
    return encryptedData;
  }
}
