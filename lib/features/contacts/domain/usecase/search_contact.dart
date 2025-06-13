import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';

import '../repositories/contact_repository.dart';

class SearchContact implements UseCase<List<Contact>,SearchContactParams>{

  final ContactRepository contactRepository;

  SearchContact(this.contactRepository);

  @override
  Future<Either<Failure, List<Contact>>> call(SearchContactParams params) async {
    return await contactRepository.searchContact(
      name: params.name,
      phoneNumber: params.phoneNumber
    );
  }

}

class SearchContactParams{
  final String? name;
  final String? phoneNumber;

  SearchContactParams({
    this.name,
    this.phoneNumber
  });
}