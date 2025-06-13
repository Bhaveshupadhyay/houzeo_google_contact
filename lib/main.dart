import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/theme/theme.dart';
import 'package:houzeo/core/utils/database_utils.dart';
import 'package:houzeo/features/contacts/domain/usecase/add_contact.dart';
import 'package:houzeo/features/contacts/domain/usecase/delete_contact.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_all_favourites.dart';
import 'package:houzeo/features/contacts/domain/usecase/get_contact_by_id.dart';
import 'package:houzeo/features/contacts/domain/usecase/search_contact.dart';
import 'package:houzeo/features/contacts/domain/usecase/toggle_favourite.dart';
import 'package:houzeo/features/contacts/domain/usecase/update_contact.dart';
import 'package:houzeo/features/contacts/presentation/cubit/conatct_search_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_favourite_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_load_by_id_cubit.dart';
import 'package:houzeo/features/contacts/presentation/screens/dashboard_screen.dart';

import 'features/contacts/data/datasource/contact_local_data_source.dart';
import 'features/contacts/data/repositories/contact_repository_impl.dart';
import 'features/contacts/domain/usecase/get_all_contacts.dart';
import 'features/contacts/presentation/cubit/contact_crud_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db=await DatabaseUtils().database;

  final contactRepo=ContactRepositoryImpl(ContactLocalDataSourceImpl(
      db
  ));
  runApp(ScreenUtilInit(
    designSize: const Size(430, 932),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_ , child) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (create)=>ContactCrudCubit(
              getAllContacts: GetAllContacts(contactRepo),
              addContact: AddContact(contactRepo),
              updateContact: UpdateContact(contactRepo),
              deleteContact: DeleteContact(contactRepo),
            )
            ),
            BlocProvider(create: (create)=>ContactLoadByIdCubit(
                getContactById: GetContactById(contactRepo),
                toggleFavourite: ToggleFavourite(contactRepo)
            )
            ),
            BlocProvider(create: (create)=>ContactFavouriteCubit(
                getAllFavourites: GetAllFavourites(contactRepo),
                toggleFavourite: ToggleFavourite(contactRepo)
            )
            ),
            BlocProvider(create: (create)=>ContactSearchCubit(
                searchContact: SearchContact(contactRepo)
            )
            ),
          ],
          child: child!
      );
    },
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Houzeo',
        theme: AppTheme().light,
        home: const DashboardScreen()
    );
  }
}
