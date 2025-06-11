import 'package:houzeo/core/error/failure.dart';

sealed class ContactState{}

final class ContactInitial extends ContactState{}
final class ContactLoading extends ContactState{}
final class ContactLoaded<T> extends ContactState{
  final T data;
  ContactLoaded(this.data);
}

final class ContactFailure extends ContactState{
  final Failure failure;

  ContactFailure(this.failure);
}
final class ContactAdded extends ContactState{}
final class ContactDeleted extends ContactState{}
final class ContactUpdated extends ContactState{}
final class ContactFavouriteToggled extends ContactState{}