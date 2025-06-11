import 'package:houzeo/core/error/failure.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model/contact_model.dart';

abstract interface class ContactLocalDataSource {
  Future<List<ContactModel>> loadContacts();
  Future<int> updateContact({required ContactModel contact});
  Future<int> addContact({required ContactModel contact});
  Future<int> deleteContact({required int contactId});
  Future<List<ContactModel>> favouriteContacts();
  Future<int> toggleFavourite({required int contactId});
  Future<ContactModel?> getContact({required int contactId});
}

class ContactLocalDataSourceImpl extends ContactLocalDataSource {
  final Database database;

  ContactLocalDataSourceImpl(this.database);

  @override
  Future<int> addContact({required ContactModel contact}) async {
    try {
      return await database.insert('contacts', contact.toMap());
    } catch (e) {
      throw Failure('Error adding contact: $e');
    }
  }

  @override
  Future<int> deleteContact({required int contactId}) async {
    try {
      return await database.delete('contacts', where: 'id = ?', whereArgs: [contactId]);
    } catch (e) {
      throw Failure('Error deleting contact: $e');
    }
  }

  @override
  Future<List<ContactModel>> favouriteContacts() async {
    try {
      final maps = await database.query(
        'contacts',
        where: 'isFavourite = ?',
        whereArgs: [1],
      );
      return maps.map((map) => ContactModel.fromMap(map)).toList();
    } catch (e) {
      throw Failure('Error loading favourite contacts: $e');
    }
  }

  @override
  Future<ContactModel?> getContact({required int contactId}) async {
    try {
      final result = await database.query(
        'contacts',
        where: 'id = ?',
        whereArgs: [contactId],
      );

      if (result.isNotEmpty) {
        return ContactModel.fromMap(result.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Failure('Error fetching contact by ID: $e');
    }
  }

  @override
  Future<List<ContactModel>> loadContacts() async {
    try {
      final maps = await database.query('contacts');
      print(maps);
      return maps.map((map) => ContactModel.fromMap(map)).toList();
    } catch (e) {
      throw Failure('Error loading contacts: $e');
    }
  }

  @override
  Future<int> updateContact({required ContactModel contact}) async {
    try {
      return await database.update(
        'contacts',
        contact.toMap(),
        where: 'id = ?',
        whereArgs: [contact.id],
      );
    } catch (e) {
      throw Failure('Error updating contact: $e');
    }
  }

  @override
  Future<int> toggleFavourite({required int contactId}) async {
    try {
      final contact = await getContact(contactId: contactId);
      if (contact != null) {
        final updated = contact.copyWith(isFavourite: !contact.isFavourite);
        return await updateContact(contact: updated);
      }
      return 0;
    } catch (e) {
      throw Failure('Error toggling favourite: $e');
    }
  }
}
