import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/common_btn.dart';
import 'package:houzeo/core/common/widgets/common_phone_field.dart';
import 'package:houzeo/core/common/widgets/common_textfield.dart';
import 'package:houzeo/core/theme/app_color.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_favourite_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_load_by_id_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/utils/show_snackbar.dart';
import '../../domain/entities/contact.dart';
import '../cubit/conatct_search_cubit.dart';
import '../cubit/contact_crud_cubit.dart';


class ContactEditDetails extends StatefulWidget {
  final Contact contact;
  const ContactEditDetails({super.key, required this.contact});

  @override
  State<ContactEditDetails> createState() => _ContactEditDetailsState();
}

class _ContactEditDetailsState extends State<ContactEditDetails> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _contactImgPath;
  PhoneNumber? _phoneNumber;

  @override
  void initState() {
     _firstNameController.text= widget.contact.firstName;
     _middleNameController.text= widget.contact.middleName??'';
     _lastNameController.text= widget.contact.lastName??'';
     _companyController.text= widget.contact.company??'';
     _emailController.text= widget.contact.email??'';
     _phoneNumber= PhoneNumber(countryISOCode: widget.contact.countryCode,
         countryCode: '+91', number: widget.contact.phoneNumber);
     _phoneController.text= widget.contact.phoneNumber;
     _contactImgPath= widget.contact.profileImage;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return BlocListener<ContactCrudCubit,ContactState>(
      listener: (BuildContext context, ContactState state) {
        if(state is ContactUpdated){
          showSnackBar(context, 'Contact Updated');
          context.read<ContactLoadByIdCubit>().getContactById(contactId: widget.contact.id!);
          context.read<ContactCrudCubit>().loadAllContacts();
          context.read<ContactFavouriteCubit>().loadAllFavouriteContacts();
          Navigator.pop(context);

        }
        else if(state is ContactFailure){
          showSnackBar(context, state.failure.message, AppColors.errorColor);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close,size: 20.sp,),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 5.w,),
                    Text('Edit Contact',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Spacer(),
                    CommonBtn(
                      text: 'Save',
                      onTap: (){
                        if(_formKey.currentState!.validate() && (_phoneNumber?.isValidNumber()??false)){
                          context.read<ContactCrudCubit>().updateContact(
                              contactId: widget.contact.id!,
                              firstName: _firstNameController.text,
                              middleName: _middleNameController.text,
                              lastName: _lastNameController.text,
                              company: _companyController.text,
                              email: _emailController.text,
                              profileImage: _contactImgPath,
                              phoneNumber: _phoneNumber!.number,
                              countryCode: _phoneNumber!.countryISOCode,
                              isFavourite: widget.contact.isFavourite
                          );
                        }
                      },
                      fillColor: AppColors.primaryColor,
                      textColor: AppColors.white,
                    ),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                  
                            ContactImagePicker(
                              onImagePicked: (imgPath){
                                _contactImgPath= imgPath;
                              },
                              imagePath: _contactImgPath,
                            ),
                  
                            SizedBox(height: 40.h,),
                  
                            CommonTextField(
                              hintText: 'First Name',
                              textEditingController: _firstNameController,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name',
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                            CommonTextField(
                              hintText: 'Middle Name',
                              textEditingController: _middleNameController,
                              keyboardType: TextInputType.text,
                              labelText: 'Middle Name',
                              isOptional: true,
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                            CommonTextField(
                              hintText: 'Surname',
                              textEditingController: _lastNameController,
                              keyboardType: TextInputType.text,
                              labelText: 'Surname',
                              isOptional: true,
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                            CommonTextField(
                              hintText: 'Company',
                              textEditingController: _companyController,
                              keyboardType: TextInputType.text,
                              labelText: 'Company',
                              isOptional: true,
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                            CommonTextField(
                              hintText: 'Email',
                              textEditingController: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'Email',
                              isOptional: true,
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                            CommonPhoneField(
                              textEditingController: _phoneController,
                              onChanged: (phoneNumber){
                                _phoneNumber=phoneNumber;
                              },
                              countryIsoCode: widget.contact.countryCode,
                            ),
                  
                            SizedBox(height: 20.h,),
                  
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
