import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class ILocale extends ILanguage {
  static ILanguage current = ILanguage.current;
  static ILanguage of(BuildContext context) => ILanguage.of(context);
}
