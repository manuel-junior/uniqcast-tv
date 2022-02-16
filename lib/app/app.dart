import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uniq_cast_tv/utils/routes/app_routes.dart';

import 'bindings/initial_bindings.dart';

import '../utils/routes/app_pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GetMaterialApp(
          title: 'Uniq Cast Tv',
          debugShowCheckedModeBanner: true,
          initialBinding: InitialBinding(),
          initialRoute: Routes.login,
          theme: ThemeData(
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context)
                  .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
            ),
          ),
          navigatorObservers: [
            GetObserver(),
          ],
          supportedLocales: const [
            Locale('en'),
          ],
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
