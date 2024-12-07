import 'dart:async';
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
import '../bottom_navbar.dart';

class ChatPage extends StatefulWidget {
  final RemoteMessage?
      message; // Define a nullable variable to store the message

  ChatPage({Key? key, this.message}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<MDMessages> chatList = [];
  Timer? timer; // Declare timer variable here

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('widget.message!.data====${widget.message?.data}');
    if (widget.message != null) {
      String requestId = widget.message!.data['request_id'];
      getChat(requestId); // Initial call to getChat
      // Start periodic timer to fetch chat every 5 seconds
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        getChat(requestId);
      });
    }
  }

  Future<void> getChat(String requestId) async {
    const String url = 'https://delivershipment.com/public/api/getChat';

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Authorization":
              "Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}"
        },
        body: {
          'request_id': requestId,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<MDMessages> messages =
            responseData.map((json) => MDMessages.fromJson(json)).toList();

        setState(() {
          // Add only new messages to the existing chatList
          chatList.addAll(messages.where((message) => !chatList
              .any((existingMessage) => existingMessage.id == message.id)));
        });
      } else {
        print('Failed to load chat data. Status code: ${response.statusCode}');
        print('response.body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
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
        chatList.add(MDMessages(text: messageText, isDriver: '1', isUser: '0'));
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
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the home screen when the back button is pressed
        Get.offAll(() => const BottomBarScreen());
        return false;
      },
      child: Scaffold(
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
                      onTap: () => Get.offAll(() => const BottomBarScreen()),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                     Text(
                      'Driver'.tr,
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
                          chatList[index].text!,
                          chatList[index].isUser!,
                          chatList[index].isDriver!,
                        ),
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
                          constraints: const BoxConstraints(
                              maxHeight: 40, minHeight: 40),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
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
      ),
    );
  }

  Widget buildChatBubble(String message, String user, String driver) {
    return Row(
      mainAxisAlignment: driver == '1' && user == '0'
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        driver == '1' && user == '0'
            ? const SizedBox()
            : const CircleAvatar(
                backgroundColor: Color(0xffBCA37F),
              ),
        SizedBox(
          width: 5.sp,
        ),
        Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: driver == '1' && user == '0'
                ? textcyanColor
                : const Color(0xffFFF2D8),
          ),
          child: Text(
            message,
            style: TextStyle(
                color:
                    driver == '1' && user == '0' ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }
}

class MDMessages {
  int? id;
  String? text;
  String? userId;
  String? requestId;
  String? isDriver;
  String? isUser;
  Null? docs;
  String? isRead;
  String? createdAt;
  String? updatedAt;

  MDMessages(
      {this.id,
      this.text,
      this.userId,
      this.requestId,
      this.isDriver,
      this.isUser,
      this.docs,
      this.isRead,
      this.createdAt,
      this.updatedAt});

  MDMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    userId = json['user_id'];
    requestId = json['request_id'];
    isDriver = json['is_driver'];
    isUser = json['is_user'];
    docs = json['docs'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['user_id'] = this.userId;
    data['request_id'] = this.requestId;
    data['is_driver'] = this.isDriver;
    data['is_user'] = this.isUser;
    data['docs'] = this.docs;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
