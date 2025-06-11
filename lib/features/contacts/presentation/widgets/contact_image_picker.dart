import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_color.dart';

class ContactImagePicker extends StatefulWidget {
  final String? imagePath;
  final void Function(String) onImagePicked;
  const ContactImagePicker({super.key, this.imagePath, required this.onImagePicked});

  @override
  State<ContactImagePicker> createState() => _ContactImagePickerState();
}

class _ContactImagePickerState extends State<ContactImagePicker> {

  String? _contactImagePath;
  File? _contactImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _contactImagePath = pickedFile.path;
        _contactImage= File(pickedFile.path);
      });
      widget.onImagePicked(pickedFile.path);
    }
  }
  @override
  void initState() {
    if(widget.imagePath!=null){
      _contactImagePath= widget.imagePath;
      _contactImage= File(widget.imagePath!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: (){
              _pickImage(ImageSource.gallery);
            },
            child: _contactImage!=null?
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle
              ),
              child: ClipOval(
                child: Image.file(_contactImage!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                :
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.shade100,
                  shape: BoxShape.circle
              ),
              child: Icon(Icons.image,
                size: 35.sp,
              ),
            ),
          ),
        ),

        SizedBox(height: 10.h,),
        Text('Add picture',
          style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.primaryColor
          ),
        ),
      ],
    );
  }
}
