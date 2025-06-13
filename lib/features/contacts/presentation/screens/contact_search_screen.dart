import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/common_textfield.dart';
import 'package:houzeo/core/utils/convert_utils.dart';
import 'package:houzeo/features/contacts/presentation/cubit/conatct_search_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';

import '../../../../core/common/widgets/empty_contacts.dart';
import '../../domain/entities/contact.dart';
import '../widgets/contact_card.dart';
import 'contact_add_details.dart';

class ContactSearchScreen extends StatefulWidget {
  const ContactSearchScreen({super.key});

  @override
  State<ContactSearchScreen> createState() => _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {

  final _searchController= TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ContactSearchCubit>().clearSearch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: CommonTextField(
                hintText: 'Search..',
                textEditingController: _searchController,
                keyboardType: TextInputType.text,
              bgColor: theme.appBarTheme.backgroundColor,
              borderRadius: BorderRadius.zero,
              inputDecoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none
              ),
              focusNode: _focusNode,
              onTextChanged: (value){
                  if(value.isNotEmpty){
                    if(ConvertUtils.isNumber(value)){
                      context.read<ContactSearchCubit>().searchContact(phoneNumber: value);
                    }
                    else{
                      context.read<ContactSearchCubit>().searchContact(name: value);
                    }
                  }
                  else{
                    context.read<ContactSearchCubit>().clearSearch();
                  }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<ContactSearchCubit,ContactState>(
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
              return SingleChildScrollView(
                child: EmptyContacts(
                  lottiePath: 'assets/lottie/empty_contacts.json',
                  title: 'No Contacts Found',
                  body: 'We couldn\'t find any contacts matching your search. Try a different keyword or add a new contact!',
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactAddDetails()));
                  },
                ),
              );
            }
          }
          return SizedBox.shrink();
        },

      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
