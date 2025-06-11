import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/domain/repositories/contact_repository.dart';

class GetContactById implements UseCase<Contact?,int>{
  final ContactRepository contactRepository;

  GetContactById(this.contactRepository);

  @override
  Future<Either<Failure, Contact?>> call(int contactId) async {
    return await contactRepository.getContact(contactId);
  }

}