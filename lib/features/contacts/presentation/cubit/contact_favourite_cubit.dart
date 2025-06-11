import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_all_favourites.dart';
import 'package:houzeo/features/contacts/domain/usecase/toggle_favourite.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';

import '../../domain/entities/contact.dart';

class ContactFavouriteCubit extends Cubit<ContactState>{

  final GetAllFavourites _getAllFavourites;
  final ToggleFavourite _toggleFavourite;

  ContactFavouriteCubit({required GetAllFavourites getAllFavourites, required ToggleFavourite toggleFavourite}):
        _getAllFavourites= getAllFavourites,
        _toggleFavourite= toggleFavourite,
        super(ContactInitial());


  Future<void> loadAllFavouriteContacts() async {
    emit(ContactLoading());
    final res= await _getAllFavourites(NoParams());
    res.fold(
            (failure){
          emit(ContactFailure(failure));
        },
            (data){
          emit(ContactLoaded<List<Contact>>(data));
        });
  }

  Future<void> toggleFavourite({
    required int contactId,
  }) async{

  }

}