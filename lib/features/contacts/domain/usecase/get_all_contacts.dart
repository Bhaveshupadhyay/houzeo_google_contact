import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/domain/repositories/contact_repository.dart';

class GetAllContacts implements UseCase<List<Contact>,NoParams>{

  final ContactRepository contactRepository;

  GetAllContacts(this.contactRepository);

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) async {
    return await contactRepository.getAllContacts();
  }
}