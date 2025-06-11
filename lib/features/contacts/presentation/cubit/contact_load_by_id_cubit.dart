import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_contact_by_id.dart';
import 'package:houzeo/features/contacts/domain/usecase/toggle_favourite.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';

import '../../domain/entities/contact.dart';

class ContactLoadByIdCubit extends Cubit<ContactState>{

  final GetContactById _getContactById;
  final ToggleFavourite _toggleFavourite;

  ContactLoadByIdCubit({required GetContactById getContactById,required ToggleFavourite toggleFavourite}):
        _getContactById=getContactById,
        _toggleFavourite= toggleFavourite,
        super(ContactInitial());

  Future<void> getContactById({
    required int contactId,
  }) async {
    emit(ContactLoading());
    final res= await _getContactById(contactId);
    res.fold(
            (failure){
          emit(ContactFailure(failure));
        },
            (contact){
          if(contact!=null) {
            emit(ContactLoaded<Contact>(contact));
          }
          else{
            emit(ContactFailure(Failure('Contact doesn\'t exist')));
          }
        });
  }


  Future<void> toggleFavourite({
    required int contactId,
  }) async{
    emit(ContactLoading());
    final res= await _toggleFavourite(contactId);
    res.fold(
            (failure){
          emit(ContactFailure(failure));
        },
            (isSuccess){
          if(isSuccess) {
            emit(ContactFavouriteToggled());
          }
          else{
            emit(ContactFailure(Failure('Failed to update Contact favourite')));
          }
        });
  }
}