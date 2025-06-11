import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/domain/repositories/contact_repository.dart';

class DeleteContact implements UseCase<bool,int>{
  final ContactRepository contactRepository;

  DeleteContact(this.contactRepository);

  @override
  Future<Either<Failure, bool>> call(int contactId) async {
    return await contactRepository.deleteContact(contactId);
  }

}