import 'package:adaptive_components/adaptive_components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

extension TypographyUtils on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => GoogleFonts.montserratTextTheme(theme.textTheme);
  ColorScheme get colors => theme.colorScheme;

  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(
    color: colors.onSurface,
  );
  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(
    color: colors.onSurface,
  );
  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(
    color: colors.onSurface,
  );
}

class Abb extends StatefulWidget {
  const Abb({Key? key}) : super(key: key);

  @override
  State<Abb> createState() => _AbbState();
}

class _AbbState extends State<Abb> {


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, dimens) {


          // Table layout
          if (dimens.maxWidth >= 600) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Acerca de"),
              ),
              body: SingleChildScrollView(
                child: AdaptiveColumn(
                  children: [
                    AdaptiveContainer(
                      columnSpan: 8,
                      child: Center(child: Image.asset('lib/assets/logo.jpg',height: 200)),
                    ),
                    AdaptiveContainer(
                      columnSpan: 8,
                      child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Fiwfiw ñi dungun',
                                  style: context.titleLarge
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          // Mobile layout
          else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Acerca de"),
              ),
              body: SingleChildScrollView(
                child: AdaptiveColumn(
                  children: [
                    AdaptiveContainer(
                      columnSpan: 4,
                      child: Center(child: Image.asset('lib/assets/logo.jpg',height: 200)),
                    ),
                    AdaptiveContainer(
                      columnSpan: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fiwfiw ñi dungun',
                              style: context.titleLarge
                            ),
                          ],
                        )
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}

