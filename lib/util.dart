import 'dart:convert';

import 'package:flutter/foundation.dart';

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) => compute(_parseAndDecode, text);