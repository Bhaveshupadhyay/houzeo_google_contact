import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/usecase/add_contact.dart';
import 'package:houzeo/features/contacts/domain/usecase/delete_contact.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_all_contacts.dart';
import 'package:houzeo/features/contacts/domain/usecase/update_contact.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';

import '../../domain/entities/contact.dart';

class ContactCrudCubit extends Cubit<ContactState>{

  final GetAllContacts _getAllContacts;
  final AddContact _addContact;
  final UpdateContact _updateContact;
  final DeleteContact _deleteContact;

  ContactCrudCubit({required GetAllContacts getAllContacts,required AddContact addContact,
    required UpdateContact updateContact, required DeleteContact deleteContact}):
      _getAllContacts=getAllContacts,
      _addContact=addContact,
      _updateContact=updateContact,
      _deleteContact=deleteContact,
        super(ContactInitial());

  Future<void> loadAllContacts() async {
    emit(ContactLoading());
    final res= await _getAllContacts(NoParams());
    res.fold(
            (failure){
              emit(ContactFailure(failure));
            },
            (data){
              emit(ContactLoaded<List<Contact>>(data));
            });
  }

  Future<void> addContact({
    required String firstName,
    String? middleName,
    String? lastName,
    String? profileImage,
    String? email,
    String? company,
    required String phoneNumber,
    required String countryCode
}) async {
    emit(ContactLoading());
    final res= await _addContact(AddContactParams(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        profileImage: profileImage,
        email: email,
        company: company,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
    ));
    res.fold(
            (failure){
              emit(ContactFailure(failure));
            },
            (isSuccess){
              if(isSuccess) {
                emit(ContactAdded());
              }
              else{
                emit(ContactFailure(Failure('Unable to add contact')));
              }
            });
  }


  Future<void> updateContact({
    required int contactId,
    required String firstName,
    String? middleName,
    String? lastName,
    String? profileImage,
    String? email,
    String? company,
    required String phoneNumber,
    required String countryCode,
    bool? isFavourite,
}) async {
    emit(ContactLoading());
    final res= await _updateContact(UpdateContactParams(
      contactId: contactId,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      profileImage: profileImage,
      email: email,
      company: company,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      isFavourite: isFavourite
    ));
    res.fold(
            (failure){
          emit(ContactFailure(failure));
        },
            (isSuccess){
              if(isSuccess) {
                emit(ContactUpdated());
              }
              else{
                emit(ContactFailure(Failure('Unable to update contact')));
              }
        });
  }

  Future<void> deleteContact({
    required int contactId,
  }) async {
    emit(ContactLoading());
    final res= await _deleteContact(contactId);
    res.fold(
            (failure){
          emit(ContactFailure(failure));
        },
            (isSuccess){
          if(isSuccess) {
            emit(ContactDeleted());
          }
          else{
            emit(ContactFailure(Failure('Contact doesn\'t exist')));
          }
        });
  }


}