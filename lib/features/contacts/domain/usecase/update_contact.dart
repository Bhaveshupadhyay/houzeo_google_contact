import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';

import '../repositories/contact_repository.dart';

class UpdateContact implements UseCase<bool,UpdateContactParams>{

  final ContactRepository contactRepository;

  UpdateContact(this.contactRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateContactParams params) async {
    return await contactRepository.updateContact(
        contactId: params.contactId,
        firstName: params.firstName,
        middleName: params.middleName,
        lastName: params.lastName,
        profileImage: params.profileImage,
        email: params.email,
        company: params.company,
        phone: params.phoneNumber,
        countryCode: params.countryCode,
      isFavourite: params.isFavourite

    );
  }

}

class UpdateContactParams{
  final int contactId;
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? profileImage;
  final String? email;
  final String? company;
  final String phoneNumber;
  final String countryCode;
  final bool? isFavourite;

  UpdateContactParams({
    required this.contactId,
    required this.firstName,
    this.middleName,
    this.lastName,
    this.profileImage,
    this.email,
    this.company,
    required this.phoneNumber,
    required this.countryCode,
    this.isFavourite=false,
  });
}