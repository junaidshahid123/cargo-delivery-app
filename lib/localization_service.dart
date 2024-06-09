import 'dart:ui';
import 'package:get/get.dart';

class LocalizationService {
  static void changeLocale(Locale newLocale) {
    Get.updateLocale(newLocale);
  }

  static Map<String, Map<String, String>> translations = {
    'en': {
      "Driver": "Driver",
      "hello": "Hello",
      "welcome": "Welcome",
      "confirm location": "Confirm Location",
      "hello again!": "Hello Again!",
      "Quick Delivery at\nyour Home ": "Quick Delivery at\nyour Home ",
      "Book now": "Book now",
      "No Ride In progress": "No Ride In progress",
      "Quick another order": "Quick another order",
      "SAR 3.22/Km": "SAR 3.22/Km",
      "Truck": "Truck",
      "Car": "Car",
      "Profile": "Profile",
      "Near by drivers": "Near by drivers",
      "Trips": "Trips",
      "Notifications": "Notifications",
      "Payment": "Payment",
      "Delete Account": "Delete Account",
      "Are You Sure You Want To\n Delete Your Account?":
          "Are You Sure You Want To\n Delete Your Account?",
      "Sign Out": "Sign Out",
      "Are You Sure You Want To\nSign Out?":
          "Are You Sure You Want To\nSign Out?",
      "Add Your Details for delivery": "Add Your Details for delivery ",
      "Add Picture *": "Add Picture *",
      "Parcel Location": "Parcel Location",
      "Receiver Location": "Receiver Location",
      "Select Vehicle Category": "Select Vehicle Category",
      "Please Select Delivery Date": "Please Select Delivery Date",
      "Submit": "Submit",
      "Your Request Sent": "Your Request Sent",
      "We have sent your Delivery Request to your nearby diver":
          "We have sent your Delivery Request to your nearby diver",
      "OK": "OK",
      "Proceed": "Proceed",
      "How May i help you?": "How May i help you?",
      "Password": "Password",
      "Confirm Password": "Confirm Password",
      "Update": "Update",
      "NO": "NO",
      "YES": "YES",
      "Payments": "Payments",
      "Contact Information": "Contact Information",
      "Email": "Email",
      "Address": "Address",
      "Airport Road,Al-Ryadh": "Airport Road,Al-Ryadh",
      "Payment Method": "Payment Method",
      "Debit Card": "Debit Card",
      "Pay by receiver method": "Pay by receiver method",
      "enter details": "enter details",
      "Save Now": "Save Now",
      "Recent": "Recent",
      "7 min ago": "7 min ago",
      "Now you can send anything anywhere in a very low cost":
          "Now you can send anything anywhere in a very low cost",
      "SAR 74.67": "SAR 74.67",
      "Fill Your Details or Continue with\n Social media":
          "Fill Your Details or Continue with\n Social media",
      "Mobile Number": "Mobile Number",
      "Enter valid  phone number": "Enter valid  phone number",
      "Enter 6 characters password": "Enter 6 characters password",
      "Forgot Password ?": "Forgot Password ?",
      "Login": "Login",
      "New User ?": "New User ?",
      "Create Account": "Create Account",
      "Sign Up": "Sign Up",
      "Enter valid name": "Enter valid name",
      "Full Name": "Full Name",
      "Enter valid email": "Enter valid email",
      "Enter valid Password": "Enter valid Password",
      "Password do not match": "Password do not match",
      "Next": "Next",
      "Already Have Account ?": "Already Have Account ?",
      "Log In": "Log In",
      "Forgot Password": "Forgot Password",
      "Enter Your Mobile Number to reset\nYour Password":
          "Enter Your Mobile Number to reset\nYour Password",
      "Reset Password": "Reset Password",
      "Check your Mobile": "Check your Mobile",
      "We have sent a password recovery code to your Mobile Number":
          "We have sent a password recovery code to your Mobile Number",
      "OTP Verification": "OTP Verification",
      "Please Check Your Mobile \nto See The Verification Code":
          "Please Check Your Mobile \nto See The Verification Code",
      "OTP Code": "OTP Code",
      "Verify": "Verify",
      "Resend code": "Resend code",
      "Please Enter Your New Password\n To Continue":
          "Please Enter Your New Password\n To Continue",
      "Enter 6 characters  password": "Enter 6 characters  password",
      "New Password": "New Password",
      "confirm password do not match": "confirm password do not match",
      "Confirm New Password": "Confirm New Password",
      "Reset & Login": "Reset & Login",
      // Add more key-value pairs for English translations
    },
    'ar': {
      "Reset & Login": "إعادة التعيين وتسجيل الدخول",
      "Confirm New Password": "تأكيد كلمة المرور الجديدة",
      "confirm password do not match": "غير مطابق تأكيد كلمة المرور",
      "New Password": "كلمة المرور الجديدة",
      "Enter 6 characters  password": "أدخل كلمة المرور المكونة من 6 أحرف",
      "Please Enter Your New Password\n To Continue":
          "الرجاء إدخال كلمة المرور الجديدة للمتابعة",
      "Resend code": "أعد إرسال الرمز",
      "Verify": "تحقق",
      "OTP Code": "رمز OTP",
      "Please Check Your Mobile \nto See The Verification Code":
          "يرجى التحقق من هاتفك لإدخال رمز التحقق",
      "OTP Verification": "التحقق من OTP",
      "We have sent a password recovery code to your Mobile Number":
          "لقد أرسلنا رمز استعادة كلمة المرور إلى رقم هاتفك ",
      "Check your Mobile": "تحقق من هاتفك",
      "Reset Password": "إعادة تعيين كلمة المرور",
      "Enter Your Mobile Number to reset\nYour Password":
          "أدخل رقم هاتفك لإعادة تعيين كلمة المرور الخاصة بك",
      "Forgot Password": "هل نسيت كلمة المرور؟",
      "Log In": "تسجيل الدخول",
      "Already Have Account ?": "هل لديك حساب بالفعل؟",
      "Next": "التالي",
      "Password do not match": "كلمة المرور غير مطابقة",
      "Enter valid Password": "أدخل كلمة مرور صالحة",
      "Enter valid email": "أدخل بريدًا إلكترونيًا صالحًا",
      "Full Name": "الاسم كامل",
      "Enter valid name": "أدخل اسمًا صالحًا",
      "Sign Up": "تسجيل",
      "Create Account": "إنشاء حساب",
      "New User ?": "مستخدم جديد ؟",
      "Login": "تسجيل الدخول",
      "Forgot Password ?": "هل نسيت كلمة المرور؟",
      "Enter 6 characters password": "أدخل كلمة المرور المكونة من 6 أحرف",
      "Enter valid  phone number": "أدخل رقم هاتف صالح",
      "Mobile Number": "رقم هاتفك",
      "Fill Your Details to Continue": "املأ التفاصيل الخاصة بك للمتابعة",
      "SAR 74.67": "74.67 ريال سعودي",
      "Now you can send anything anywhere in a very low cost":
          "الآن يمكنك إرسال أي شيء إلى أي مكان بتكلفة مناسبة",
      "7 min ago": "منذ 7 دقائق",
      "Recent": "مؤخرًا",
      "Save Now": "احفظ الان",
      "enter details": "أدخل التفاصيل",
      "Pay by receiver method": "الدفع عن طريق المستلم",
      "Debit Card": "بطاقة ائتمان",
      "Payment Method": "طريقة الدفع او السداد",
      "Airport Road,Al-Ryadh": "طريق المطار، الرياض",
      "Address": "العنوان",
      "Email": "بريد إلكتروني",
      "Contact Information": "معلومات الاتصال",
      "Payments": "المدفوعات",
      "YES": "نعم",
      "NO": "لا",
      "Confirm Password": "تأكيد كلمة المرور",
      "Update": "تحديث",
      "Password": "كلمة المرور",
      "How May i help you?": "كيف يمكنني مساعدتك؟",
      "Driver": "سائق",
      "hello": "مرحبا",
      "welcome": "أهلا بك",
      "confirm location": "تأكيد الموقع",
      "": "توصيل سريع إلى منزلك",
      "hello again!": "مرحبا مجددا!",
      "Quick Delivery at\nyour Home ": "توصيل سريع إلى منزلك",
      "Book now": "احجز الآن",
      "No Ride In progress": "لا توجد رحلة قيد التنفيذ",
      "Quick another order": "طلب آخر",
      "SAR 3.22/Km": "3.22 ريال سعودي/كم",
      "Truck": "شاحنة",
      "Car": "سيارة",
      "Profile": "الملف الشخصي",
      "Near by drivers": "السائقين القريبين",
      "Trips": "رحلات",
      "Notifications": "إشعارات",
      "Payment": "الدفع",
      "Delete Account": "حذف الحساب",
      "Are You Sure You Want To\n Delete Your Account?":
          "هل انت متأكد انك تريد حذف حسابك؟",
      "Sign Out": "تسجيل الخروج",
      "Are You Sure You Want To\nSign Out?":
          "هل أنت متأكد أنك تريد تسجيل الخروج؟",
      "Add Your Details for delivery": "أدخل بياناتك للتسليم",
      "Add Picture *": "إضافة الصورة *",
      "Parcel Location": "موقع الشحنة",
      "Receiver Location": "موقع المستلم",
      "Select Vehicle Category": "حدد فئة السيارة",
      "Please Select Delivery Date": "الرجاء تحديد تاريخ التسليم",
      "Submit": "إرسال",
      "Your Request Sent": "تم إرسال طلبك",
      "We have sent your Delivery Request to your nearby diver":
          "لقد أرسلنا طلب التسليم الخاص بك إلى السائق القريب منك",
      "OK": "موافق",
      "Proceed": "تابع"

      // Add more key-value pairs for Arabic translations
    },
  };

  static Map<String, Map<String, String>> getKeys() => translations;

  static Future<LocalizationService> init() async {
    return LocalizationService();
  }

  static Future<void> updateLocale(String languageCode) async {
    await Get.updateLocale(Locale(languageCode));
  }
}
