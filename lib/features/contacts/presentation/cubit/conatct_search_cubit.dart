import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:houzeo/features/contacts/domain/usecase/search_contact.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';

import '../../domain/entities/contact.dart';

class ContactSearchCubit extends Cubit<ContactState>{

  final SearchContact _searchContact;

  ContactSearchCubit({required SearchContact searchContact}):
        _searchContact= searchContact,
        super(ContactInitial());

  Future<void> searchContact({
    String? name,
    String? phoneNumber,
  }) async {

    if(name!=null || phoneNumber!=null){
      emit(ContactLoading());
      final res= await _searchContact(SearchContactParams(name: name,phoneNumber: phoneNumber));
      res.fold(
              (failure){
            emit(ContactFailure(failure));
          },
              (contacts){
            emit(ContactLoaded<List<Contact>>(contacts));
          });
    }
  }

  void clearSearch(){
    emit(ContactInitial());
  }
}