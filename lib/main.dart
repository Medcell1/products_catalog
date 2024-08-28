import 'package:path_provider/path_provider.dart';
import 'package:product_catalog/view/splash_screen.dart';
import 'package:product_catalog/view/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('products');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Globals.init(context);
    return MultiProvider(
      providers: Globals.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Globals.appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
