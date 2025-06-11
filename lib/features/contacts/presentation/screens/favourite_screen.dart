import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_favourite_cubit.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_favourite_card.dart';

import '../../../../core/common/widgets/empty_contacts.dart';
import '../cubit/contact_load_by_id_cubit.dart';
import '../cubit/contact_state.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {


  @override
  void initState() {
    context.read<ContactFavouriteCubit>().loadAllFavouriteContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactLoadByIdCubit, ContactState>(
      listener: (BuildContext context, ContactState state) {
        if(state is ContactFavouriteToggled){
          context.read<ContactFavouriteCubit>().loadAllFavouriteContacts();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ContactFavouriteCubit,ContactState>(
              builder: (BuildContext context, ContactState state) {
                if(state is ContactLoaded<List<Contact>>){
                  if(state.data.isNotEmpty){
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                      itemCount: state.data.length,
                      itemBuilder: (context,index){
                        return ContactFavouriteCard(
                          contact: state.data[index],
                          onFavouriteToggle: () {
                            context.read<ContactLoadByIdCubit>().toggleFavourite(contactId: state.data[index].id!);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10.h,);
                      },
                    );
                  }
                  else{
                    return EmptyContacts(
                      lottiePath: 'assets/lottie/empty_fav_contacts.json',
                      title: 'No Favourite Contacts',
                      body: 'Mark a contact as favourite to see it here.',
                    );
                  }
                }
                return SizedBox.shrink();
              },

            ),
          ),
        ],
      ),

    );
  }
}
