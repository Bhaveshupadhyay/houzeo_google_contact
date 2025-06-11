class Contact{
  final int? id;
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? profileImage;
  final String? email;
  final String? company;
  final String phoneNumber;
  final String countryCode;
  final bool isFavourite;

  Contact({
    this.id,
    required this.firstName,
    this.middleName,
    this.lastName,
    this.profileImage,
    this.email,
    this.company,
    required this.phoneNumber,
    required this.countryCode,
    this.isFavourite=false
  });
}