// localized_translations.dart

import 'package:get/get.dart';
import 'localization_service.dart'; // Import your LocalizationService

class LocalizedTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => LocalizationService.getKeys();
}