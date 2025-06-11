import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/common_btn.dart';
import 'package:houzeo/core/common/widgets/common_phone_field.dart';
import 'package:houzeo/core/common/widgets/common_textfield.dart';
import 'package:houzeo/core/theme/app_color.dart';
import 'package:houzeo/core/utils/show_snackbar.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_crud_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';

class ContactAddDetails extends StatefulWidget {
  const ContactAddDetails({super.key});

  @override
  State<ContactAddDetails> createState() => _ContactAddDetailsState();
}

class _ContactAddDetailsState extends State<ContactAddDetails> {
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
        if(state is ContactAdded){
          showSnackBar(context, 'Contact Added');
          context.read<ContactCrudCubit>().loadAllContacts();
          Navigator.pop(context);
          
        }
        else if(state is ContactFailure){
          showSnackBar(context, state.failure.message, AppColors.errorColor);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Contact',
            style: theme.textTheme.bodyMedium,
          ),
          centerTitle: false,
          actions: [
            CommonBtn(
              text: 'Save',
              onTap: (){
                if(_formKey.currentState!.validate() && (_phoneNumber?.isValidNumber()??false)){
                  context.read<ContactCrudCubit>().addContact(
                      firstName: _firstNameController.text,
                      middleName: _middleNameController.text,
                      lastName: _lastNameController.text,
                      company: _companyController.text,
                      email: _emailController.text,
                      profileImage: _contactImgPath,
                      phoneNumber: _phoneNumber!.number,
                      countryCode: _phoneNumber!.countryISOCode
                  );
                }
              },
              fillColor: AppColors.primaryColor,
              textColor: AppColors.white,

            ),
            SizedBox(width: 10.w,),
          ],
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ContactImagePicker(
                    onImagePicked: (imgPath){
                      _contactImgPath= imgPath;
                    },
                  ),

                  SizedBox(height: 20.h,),

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
                      }

                  ),

                  SizedBox(height: 20.h,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
