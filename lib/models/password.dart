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

  PasswordModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    userId = json['user_id'];
    createdAt = DateTime.parse(json['created_at']);
    category = json['category'];
    appName = json['appName'];
    username = json['username'];
    password = json['password'];
    websiteUrl = json['websiteUrl'];
    cardNumber = json['cardNumber'];
    nameOnCard = json['nameOnCard'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    nickName = json['nickName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    identityNumber = json['identityNumber'];
    addressName = json['addressName'];
    addressOrganisation = json['addressOrganisation'];
    addressPhone = json['addressPhone'];
    addressEmail = json['addressEmail'];
    addressRegion = json['addressRegion'];
    addressStreetAddress = json['addressStreetAddress'];
    addressCity = json['addressCity'];
    addressPostalCode = json['addressPostalCode'];
    generalText = json['generalText'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['created_at'] = createdAt.toIso8601String();
    data['category'] = category;
    data['appName'] = appName;
    data['username'] = username;
    data['password'] = password;
    data['websiteUrl'] = websiteUrl;
    data['cardNumber'] = cardNumber;
    data['nameOnCard'] = nameOnCard;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['nickName'] = nickName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['identityNumber'] = identityNumber;
    data['addressName'] = addressName;
    data['addressOrganisation'] = addressOrganisation;
    data['addressPhone'] = addressPhone;
    data['addressEmail'] = addressEmail;
    data['addressRegion'] = addressRegion;
    data['addressStreetAddress'] = addressStreetAddress;
    data['addressCity'] = addressCity;
    data['addressPostalCode'] = addressPostalCode;
    data['generalText'] = generalText;
    data['notes'] = notes;
    return data;
  }
}
