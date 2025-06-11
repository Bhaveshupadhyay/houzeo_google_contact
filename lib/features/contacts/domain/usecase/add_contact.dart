import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';

import '../repositories/contact_repository.dart';

class AddContact implements UseCase<bool,AddContactParams>{

  final ContactRepository contactRepository;

  AddContact(this.contactRepository);

  @override
  Future<Either<Failure, bool>> call(AddContactParams params) async {
    return await contactRepository.addContact(
        firstName: params.firstName,
        middleName: params.middleName,
        lastName: params.lastName,
        profileImage: params.profileImage,
        email: params.email,
        company: params.company,
        phone: params.phoneNumber,
        countryCode: params.countryCode
    );
  }

}

class AddContactParams{
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? profileImage;
  final String? email;
  final String? company;
  final String phoneNumber;
  final String countryCode;

  AddContactParams({
    required this.firstName,
    this.middleName,
    this.lastName,
    this.profileImage,
    this.email,
    this.company,
    required this.phoneNumber,
    required this.countryCode,
});
}