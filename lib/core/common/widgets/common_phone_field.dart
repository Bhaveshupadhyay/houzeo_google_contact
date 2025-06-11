import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CommonPhoneField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(PhoneNumber) onChanged;
  final String countryIsoCode;

  const CommonPhoneField({super.key,
    required this.textEditingController,
    required this.onChanged,
    this.countryIsoCode='IN'
  });

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return IntlPhoneField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: 'Phone Number',
      ),
      initialCountryCode: countryIsoCode,
      onChanged: onChanged,
      style: theme.textTheme.bodySmall,
      dropdownTextStyle: theme.textTheme.bodySmall,
      pickerDialogStyle: PickerDialogStyle(
          countryNameStyle: theme.textTheme.bodySmall,
          countryCodeStyle: theme.textTheme.bodySmall,
          searchFieldPadding: EdgeInsets.symmetric(vertical: 0.h),
          searchFieldInputDecoration: InputDecoration(
            hintText: 'Search country',
            hintStyle: theme.textTheme.bodySmall,
            labelStyle: theme.textTheme.bodySmall,
          )
      ),
    );
  }
}
