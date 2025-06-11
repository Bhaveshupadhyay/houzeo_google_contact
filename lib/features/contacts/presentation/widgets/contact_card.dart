import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:houzeo/features/contacts/domain/entities/contact.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_details_screen.dart';
import 'package:houzeo/features/contacts/presentation/screens/contact_search_screen.dart';
import 'package:houzeo/features/contacts/presentation/widgets/contact_circular_image.dart';

class ContactCard extends StatelessWidget {

  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>ContactDetailsScreen(
          contactId: contact.id!,
        )));
      },
      child: Row(
        spacing: 20.w,
        children: [
          ContactCircularImage(name: contact.firstName, imagePath: contact.profileImage,),
          Expanded(
            child: Text('${contact.firstName} ${contact.lastName}',
              style: theme.textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
      
        ],
      ),
    );
  }
}
