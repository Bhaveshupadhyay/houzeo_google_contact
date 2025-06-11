import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/empty_contacts.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_crud_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_add_details.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_card.dart';

import '../../../../core/theme/app_color.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  @override
  void initState() {
    context.read<ContactCrudCubit>().loadAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: BlocBuilder<ContactCrudCubit,ContactState>(
                builder: (BuildContext context, ContactState state) {
                  if(state is ContactLoaded<List<Contact>>){
                   if(state.data.isNotEmpty){
                     return ListView.separated(
                       padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                       itemCount: state.data.length,
                       itemBuilder: (context,index){
                         return ContactCard(
                             contact: state.data[index]
                         );
                       },
                       separatorBuilder: (BuildContext context, int index) {
                         return SizedBox(height: 10.h,);
                       },
                     );
                   }
                   else{
                     return EmptyContacts(
                         lottiePath: 'assets/lottie/empty_contacts.json',
                         title: 'No contacts yet!',
                         body: 'Add a new contact to get started.',
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactAddDetails()));
                       },
                     );
                   }
                  }
                  return SizedBox.shrink();
                },

              ),
            )
          ],
        ),
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactAddDetails()));
            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.add,color: AppColors.white,),
          ),
        ),
      ],
    );
  }
}
