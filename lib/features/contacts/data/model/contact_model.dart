import '../../domain/entities/contact.dart';

class ContactModel extends Contact {

  ContactModel({
    super.id,
    required super.firstName,
    required super.phoneNumber,
    required super.countryCode,
    super.middleName,
    super.lastName,
    super.profileImage,
    super.company,
    super.email,
    super.isFavourite,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      firstName: map['firstName'],
      phoneNumber: map['phoneNumber'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      profileImage: map['image'],
      company: map['company'],
      email: map['email'],
      isFavourite: map['isFavourite'] == 1,
      countryCode: map['countryCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      'middleName': middleName,
      'lastName': lastName,
      'image': profileImage,
      'company': company,
      'email': email,
      'isFavourite': isFavourite ? 1 : 0,
      'countryCode': countryCode,
    };
  }

  ContactModel copyWith({
    int? id,
    String? firstName,
    String? phoneNumber,
    String? middleName,
    String? lastName,
    String? profileImage,
    String? company,
    String? email,
    bool? isFavourite,
    String? countryCode,
  }) {
    return ContactModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      company: company ?? this.company,
      email: email ?? this.email,
      isFavourite: isFavourite ?? this.isFavourite,
      countryCode: countryCode?? this.countryCode,
    );
  }
}
