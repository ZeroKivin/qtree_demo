import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  FlutterError.onError = (error) {
    print(error.stack);
  };

  runApp(
      const App(),
    );
}
