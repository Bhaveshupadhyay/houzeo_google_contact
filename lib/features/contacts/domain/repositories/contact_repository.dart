import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';

abstract interface class ContactRepository{
  Future<Either<Failure,List<Contact>>> getAllContacts();
  Future<Either<Failure,bool>> addContact({
    required String firstName,
    String? middleName,
    String? lastName,
    String? profileImage,
    String? company,
    String? email,
    required String phone,
    required String countryCode,
});

  Future<Either<Failure,bool>> updateContact({
    required int contactId,
    required String firstName,
    String? middleName,
    String? lastName,
    String? profileImage,
    String? company,
    String? email,
    required String phone,
    required String countryCode,
    bool? isFavourite,
});
  Future<Either<Failure,List<Contact>>> getFavoriteContacts();
  Future<Either<Failure,bool>> deleteContact(int contactId);
  Future<Either<Failure,bool>> toggleFavorite(int contactId);
  Future<Either<Failure,Contact?>> getContact(int contactId);
  Future<Either<Failure,List<Contact>>> searchContact({String? name, String? phoneNumber});
}