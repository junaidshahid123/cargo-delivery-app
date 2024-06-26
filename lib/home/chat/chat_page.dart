import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:http/http.dart' as http;
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/auth_controller.dart';
import '../../widgets/search_widget.dart';

class ChatPage extends StatefulWidget {
  final RemoteMessage?
  message; // Define a nullable variable to store the message

  ChatPage({Key? key, this.message}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Message> chatList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // chatList.add(widget.message!.notification!);
  }

  // Function to retrieve the request_id from SharedPreferences
  Future<String?> getRequestId() async {
    HttpOverrides.global = MyHttpOverrides();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('request_id');
  }

  void _addMessage() async {
    final requestId = await getRequestId();

    if (_controller.text.isNotEmpty) {
      String messageText = _controller.text;
      setState(() {
        chatList.add(Message(text: messageText, isMe: true));
        _controller.clear();
      });
      print('text==${messageText}');
      print('request_id==${requestId}');
      // Make the POST request
      var response = await http.post(
        Uri.parse('https://delivershipment.com/public/api/message'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}'
        },
        body: json.encode({
          'text': messageText,
          'request_id': requestId,
          'is_user': '0',
          'is_driver': '1'
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Message sent successfully');
      } else {
        // Handle error response
        print('response.statusCode ==========${response.statusCode}');
        print('Failed to send message ==========${response.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, 0),
            colors: [
              textcyanColor,
              textcyanColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Driver',
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () => showSearch(
                        context: context, delegate: CustomSearchDelegate()),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: chatList.length,
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildChatBubble(
                          chatList[index].isMe, chatList[index].text),
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Row(
                children: [
                  const Icon(
                    Icons.attachment_outlined,
                  ),
                  SizedBox(
                    width: 4.h,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 10),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _addMessage,
                        ),
                        constraints:
                            const BoxConstraints(maxHeight: 40, minHeight: 40),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: const BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.h,
                  ),
                  const Icon(Icons.emoji_emotions_outlined)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatBubble(bool isMe, String message) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? const SizedBox()
            : const CircleAvatar(
                backgroundColor: Color(0xffBCA37F),
              ),
        Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isMe ? textcyanColor : const Color(0xffFFF2D8),
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }
}

Widget buildChatBubble(bool isMe) {
  return Row(
    mainAxisAlignment:
        isMe == true ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      isMe == false
          ? const CircleAvatar(
              backgroundColor: Color(0xffBCA37F),
            )
          : const SizedBox(),
      isMe == false
          ? Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFFF2D8)),
              child: Text('How May i help you?'.tr),
            )
          : Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: textcyanColor),
              child: Text(
                'How May i help you?'.tr,
                style: TextStyle(color: Colors.white),
              ),
            )
    ],
  );
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
