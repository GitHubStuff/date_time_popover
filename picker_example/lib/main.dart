import 'package:flutter/material.dart';
import 'package:flutter_project_package/mode_themes/mode_theme.dart';

import 'scaffold_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModeTheme(
      themeDataFunction: (brightness) => (brightness == Brightness.light) ? ModeTheme.light : ModeTheme.dark,
      defaultBrightness: Brightness.light,
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: ScaffoldWidget(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
