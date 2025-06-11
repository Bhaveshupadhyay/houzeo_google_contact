import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/common/widgets/loader.dart';
import 'package:houzeo/core/theme/app_color.dart';
import 'package:houzeo/core/utils/call_phone_number.dart';
import 'package:houzeo/core/utils/custom_dialog.dart';
import 'package:houzeo/core/utils/show_snackbar.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_crud_cubit.dart';
import 'package:houzeo/features/contacts/presentation/cubit/contact_state.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_edit_details.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_circular_image.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_options_widget.dart';

import '../../domain/entities/contact.dart';
import '../cubit/contact_favourite_cubit.dart';
import '../cubit/contact_load_by_id_cubit.dart';

class ContactDetailsScreen extends StatefulWidget {
  final int contactId;
  const ContactDetailsScreen({super.key, required this.contactId});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {

  @override
  void initState() {
    context.read<ContactLoadByIdCubit>().getContactById(contactId: widget.contactId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Scaffold(
      body: BlocListener<ContactCrudCubit,ContactState>(
        listener: (BuildContext context, ContactState state) {
          if(state is ContactDeleted){
            showSnackBar(context, 'Contact Deleted');
            context.read<ContactCrudCubit>().loadAllContacts();
            context.read<ContactFavouriteCubit>().loadAllFavouriteContacts();
            Navigator.pop(context);
          }
        },
        child: BlocConsumer<ContactLoadByIdCubit,ContactState>(
          builder: (BuildContext context, ContactState state) {
            if(state is ContactLoaded<Contact>){
              final contact= state.data;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                      pinned: true,
                      actions: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactEditDetails(
                              contact: contact,
                            )));
                          },
                          child: Icon(
                              Icons.edit
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        InkWell(
                          onTap: (){
                            context.read<ContactLoadByIdCubit>().toggleFavourite(contactId: widget.contactId);
                          },
                          child: Icon(
                              contact.isFavourite? Icons.star : Icons.star_border,
                            color: contact.isFavourite? AppColors.goldenColor : AppColors.black,
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Icon(
                            Icons.settings
                        ),
                        SizedBox(width: 20.w,),
                      ]
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                      child: Column(
                        spacing: 20.h,
                        children: [
                          ContactCircularImage(
                            name: contact.firstName,
                            fontSize: 130.sp,
                            width: 200.w,
                            height: 200.w,
                            imagePath: contact.profileImage,
                          ),
                          Text('${contact.firstName} ${contact.middleName} ${contact.lastName}',
                            style: theme.textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),


                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        spacing: 20.w,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ContactOptionsWidget(
                              onTap: () async {
                                await callNumber(contact.phoneNumber);
                              },
                              icon: Icons.phone_outlined,
                              text: 'Call'
                          ),
                          ContactOptionsWidget(
                              onTap: (){

                              },
                              icon: Icons.message_outlined,
                              text: 'Text'
                          ),
                          ContactOptionsWidget(
                              onTap: (){

                              },
                              icon: Icons.video_call_outlined,
                              text: 'Video'
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                        decoration: BoxDecoration(
                            color: theme.textTheme.titleSmall?.color?.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(15.r)
                        ),
                        child: Column(
                          spacing: 30.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact info',
                              style: theme.textTheme.titleMedium,
                            ),

                            InkWell(
                              onTap: () async {
                                await callNumber(contact.phoneNumber);
                              },
                              child: Row(
                                spacing: 20.w,
                                children: [
                                  Icon(Icons.phone_outlined,
                                    size: 30.sp,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${contact.countryCode} ${contact.phoneNumber}',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      Text('Mobile',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(Icons.video_call_outlined,
                                    size: 30.sp,
                                  ),
                                  Icon(Icons.message_outlined,
                                    size: 30.sp,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                      child: Column(
                        spacing: 30.h,
                        children: [
                          _contactSettingIcon(icon: Icons.share_outlined, settingName: 'Share contact', theme: theme),
                          _contactSettingIcon(
                              icon: Icons.delete_outline,
                              settingName: 'Delete',
                              theme: theme,
                              settingsColor: AppColors.red,
                            onTap: (){
                                CustomDialog.showDeleteContactDialog(
                                    context,
                                    contactName: contact.firstName,
                                    onDelete: (){
                                      context.read<ContactCrudCubit>().deleteContact(contactId: widget.contactId);
                                    }
                                );
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            else if(state is ContactLoading){
              return Loader();
            }
            return SizedBox.shrink();
          },
          listener: (BuildContext context, ContactState state) {
            if(state is ContactFavouriteToggled){
              context.read<ContactLoadByIdCubit>().getContactById(contactId: widget.contactId);
              context.read<ContactFavouriteCubit>().loadAllFavouriteContacts();
            }
          },
        ),
      ),
    );
  }

  Widget _contactSettingIcon({
    required IconData icon,
    required String settingName,
    required ThemeData theme,
    Color? settingsColor,
    VoidCallback? onTap
  })=>
      InkWell(
        onTap: onTap,
        child: Row(
          spacing: 20.w,
          children: [
            Icon(icon,
              size: 30.sp,
              color: settingsColor,
            ),
            Text(settingName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: settingsColor
              ),
            ),
          ],
        ),
      );
}
