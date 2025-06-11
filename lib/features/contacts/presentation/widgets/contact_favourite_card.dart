import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/core/theme/app_color.dart';

import '../../../../core/utils/call_phone_number.dart';
import '../../domain/entities/contact.dart';
import '../screens/contact_details_screen.dart';
import 'contact_circular_image.dart';

class ContactFavouriteCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onFavouriteToggle;

  const ContactFavouriteCard({
    super.key,
    required this.contact,
    required this.onFavouriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Card(
      elevation: 0,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactDetailsScreen(
            contactId: contact.id!,
          )));
        },
        borderRadius: BorderRadius.circular(12.w),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              ContactCircularImage(name: contact.firstName, imagePath: contact.profileImage,),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${contact.firstName} ${contact.lastName}',
                      style: theme.textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  contact.isFavourite ? Icons.star_rounded : Icons.star_border_rounded,
                  color: contact.isFavourite ? AppColors.goldenColor : AppColors.black,
                  size: 28.sp,
                ),
                onPressed: onFavouriteToggle,
              ),
              IconButton(
                icon: Icon(
                  Icons.call,
                  size: 28.sp,
                ),
                onPressed: () async {
                  await callNumber(contact.phoneNumber);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
