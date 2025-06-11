import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/features/contacts/data/datasource/contact_local_data_source.dart';
import 'package:houzeo/features/contacts/data/model/contact_model.dart';

import 'package:houzeo/features/contacts/domain/entities/contact.dart';

import '../../domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository{
  final ContactLocalDataSource contactLocalDataSource;

  ContactRepositoryImpl(this.contactLocalDataSource);

  @override
  Future<Either<Failure, bool>> addContact({required String firstName, String? middleName,
    String? lastName, String? profileImage, String? company, String? email, required String phone,
    required String countryCode}) async{
    try{
      final res= await contactLocalDataSource.addContact(contact:
      ContactModel(
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
          profileImage: profileImage,
          company: company,
          email: email,
          phoneNumber: phone,
        countryCode: countryCode
      ));
      return right(res!=0);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,bool>> deleteContact(int contactId) async {
    try{
      final res= await contactLocalDataSource.deleteContact(contactId: contactId);
      return right(res!=0);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getAllContacts() async {
    try{
      final res= await contactLocalDataSource.loadContacts();
      return right(res);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,Contact?>> getContact(int contactId) async {
    try{
      final res= await contactLocalDataSource.getContact(contactId: contactId);
      return right(res);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,List<Contact>>> getFavoriteContacts() async {
    try{
      final res= await contactLocalDataSource.favouriteContacts();
      return right(res);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,bool>> toggleFavorite(int contactId) async {
    try{
      final res= await contactLocalDataSource.toggleFavourite(contactId: contactId);
      return right(res!=0);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,bool>> updateContact({required int contactId, required String firstName,
    String? middleName, String? lastName, String? profileImage, String? company, String? email,
    required String phone,required String countryCode}) async {
    try{
      final res= await contactLocalDataSource.updateContact(contact:
      ContactModel(
        id: contactId,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        profileImage: profileImage,
        company: company,
        email: email,
        phoneNumber: phone,
        countryCode: countryCode
      ));
      return right(res!=0);
    }
    on Failure catch(e){
      return left(Failure(e.message));
    }
  }

}