import 'package:fpdart/fpdart.dart';
import 'package:houzeo/core/error/failure.dart';
import 'package:houzeo/core/usecase/usecase.dart';
import 'package:houzeo/features/contacts/domain/repositories/contact_repository.dart';

class ToggleFavourite implements UseCase<bool,int>{
  final ContactRepository contactRepository;

  ToggleFavourite(this.contactRepository);

  @override
  Future<Either<Failure, bool>> call(int contactId) async {
    return await contactRepository.toggleFavorite(contactId);
  }

}