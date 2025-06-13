import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share_plus/share_plus.dart';

Future<void> callNumber(String phoneNumber) async {

  await FlutterPhoneDirectCaller.callNumber(phoneNumber);
}

void shareContact({String? contactName, String? phoneNumber,String? email}) {
  final String contactInfo = """
    Name: $contactName
    Phone: $phoneNumber
    Email: $email
    """;
  SharePlus.instance.share(
      ShareParams(text: contactInfo)
  );
}
