import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';

void main() async {
  final serviceAccount = File('C:/Users/pc/StudioProjects/cargo_delivery_app/cargo_delivery_app/assets/service-account-file.json').readAsStringSync();

  final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccount);
  final scopes = ['https://www.googleapis.com/auth/cloud-platform'];

  final authClient = await clientViaServiceAccount(accountCredentials, scopes);

  final accessToken = authClient.credentials.accessToken.data;

  print('OAuth2 Token: $accessToken');

  authClient.close();
}
