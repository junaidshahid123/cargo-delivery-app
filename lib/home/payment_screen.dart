import 'dart:convert';
import 'dart:io';
import 'package:cargo_delivery_app/constant/colors_utils.dart';
import 'package:cargo_delivery_app/home/chat/chat_page.dart';
import 'package:cargo_delivery_app/home/payment_webview_screen.dart';
import 'package:cargo_delivery_app/widgets/custom_button.dart';
import 'package:cargo_delivery_app/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../alltrips/controller/delivery_controller.dart';
import '../api/auth_controller.dart';
import '../model/MDCreateRequest.dart';
import '../model/MDGetPaymentMethodList.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bottom_navbar.dart';

class PaymentScreen extends StatefulWidget {
  final MDCreateRequest mdCreateRequest;
  final String? amount;
  final int? offerId;

  const PaymentScreen(this.mdCreateRequest, this.amount, this.offerId,
      {Key? key})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController paymentController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<List<PaymentMethod>> paymentMethods;
  String? selectedMethodId;
  String? from;
  String? to;
  String? rate;
  String? selectedPaymentMethodName;

  @override
  void initState() {
    super.initState();
    print(
        'widget.mdCreateRequest.request!.parcelAddress==${widget.mdCreateRequest.request!.parcelAddress}');
    print(
        'widget.mdCreateRequest.request!.parcelAddress==${widget.mdCreateRequest.request!.parcelAddress}');
    print('widget.amount==${widget.amount}');
    setState(() {
      from = widget.mdCreateRequest.request!.parcelAddress;
      to = widget.mdCreateRequest.request!.receiverAddress;
      rate = widget.amount;
      print('widget.offerId======${widget.offerId}');
    });
    paymentMethods = getPaymentMethods();
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    print(
        'Get.find<AuthController>().authRepo.getAuthToken()==${Get.find<AuthController>().authRepo.getAuthToken()}');

    final url = Uri.parse('http://delivershipment.com/api/paymentMethodList');
    // HttpOverrides.global = MyHttpOverrides();

    // Logging URL and Headers
    print('Request URL: $url');
    print(
        'Authorization Header: Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization":
            "Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}"
      },
    );

    // Logging Response Status and Body
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('This is jsonResponse in getPaymentMethods: $jsonResponse');
      List<PaymentMethod> methods = (jsonResponse['list'] as List)
          .map((data) => PaymentMethod.fromJson(data))
          .toList();
      return methods;
    } else {
      throw Exception('Failed to load getPaymentMethods');
    }
  }

  Future<void> acceptOffer({
    required String requestId,
    required String offerId,
    required String amount,
    required int paymentMethod,
    required String description,
  }) async {
    final url = Uri.parse('http://delivershipment.com/api/acceptOffer');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization":
            "Bearer ${Get.find<AuthController>().authRepo.getAuthToken()}"
        // If authentication is required
      },
      body: json.encode({
        'request_id': requestId,
        'offer_id': offerId,
        'amount': amount,
        'payment_method': paymentMethod,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      // The request was successful
      print('Offer accepted successfully');
      print('response.body====${response.body}');
      final responseBody = json.decode(response.body);

      if (responseBody.containsKey('data') &&
          responseBody['data'].containsKey('invoice_link')) {
        final paymentUrl = responseBody['data']['invoice_link'];

        // Navigate to WebView
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebviewScreen(url: paymentUrl),
          ),
        );
      } else {
        print('Invoice link not found in the response');
        Get.snackbar('Success', 'Request Accepted',
            backgroundColor: Colors.blue, colorText: Colors.white);
        // Handle the case where the invoice link is not present
      }
    } else {
      // There was an error
      print('Failed to accept offer: ${response.statusCode}');
      print('Failed to accept offer: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<PaymentMethod>>(
          future: paymentMethods,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data found'));
            } else {
              final methods = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text(
                          "To Proceed, Select Payment Options",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: curvedBlueColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Center(
                        child: Text(
                          "Your Delivery Order has been\naccepted details are below:",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBrownColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        height: 1.h,
                        color: curvedBlueColor.withOpacity(0.37),
                      ),
                      Center(
                        child: Text(
                          "From ${from} To ${to} \nin SAR ${rate}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: curvedBlueColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        height: 1.h,
                        color: curvedBlueColor.withOpacity(0.37),
                      ),
                      Text(
                        "Please select your payment Method",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: textBrownColor,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ...methods
                          .map((method) => Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: selectedMethodId == method.id
                                      ? Colors.blue.withOpacity(0.1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  title: Text(
                                    method.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: selectedMethodId == method.id
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 30, // Adjust the size as needed
                                        )
                                      : Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                        ),
                                  onTap: () {
                                    print('method.name====${method.name}');
                                    setState(() {
                                      selectedMethodId = method.id;
                                      selectedPaymentMethodName = method.name;
                                    });
                                  },
                                ),
                              ))
                          .toList(),
                      SizedBox(height: 20.h),
                      // CustomTextField(
                      //   controller: paymentController,
                      //   hintText: "Enter Your Payment",
                      // ),
                      // SizedBox(height: 20.h),
                      // CustomTextField(
                      //   controller: accountController,
                      //   hintText: "Bank Account/Card number",
                      // ),
                      // SizedBox(height: 20.h),
                      // CustomTextField(
                      //   controller: passwordController,
                      //   hintText: "Password",
                      // ),
                      SizedBox(height: 40.h),
                      CustomButton(
                        buttonText: "Proceed",
                        onPress: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('request_id',
                              widget.mdCreateRequest.request!.id.toString());
                          print(
                              'This is Request ID====${widget.mdCreateRequest.request!.id}');

                          print('This is Offer ID====${widget.offerId}');
                          print('Amount====${widget.amount}');
                          print(
                              'This Selected Payment Method Name====${selectedPaymentMethodName}');
                          acceptOffer(
                              requestId: widget.mdCreateRequest.request!.id!
                                  .toString(),
                              offerId: widget.offerId.toString(),
                              amount: widget.amount.toString(),
                              paymentMethod: selectedPaymentMethodName ==
                                      'Click Payment Method'
                                  ? 1
                                  : 2,
                              description: 'Safe Drive');
                          Get.offAll(() => BottomBarScreen());
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
