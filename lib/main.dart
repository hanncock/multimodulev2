import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multimodule/allmodules.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // This will apply Manrope globally to all text styles
        ),

      ),

      // home:HomePage(),
      home:Allmodules(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


// import 'package:google_fonts/google_fonts.dart';

/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        // textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning, Omar F',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Your weekly Financial update',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  InfoCard(title: 'Activado Date', value: '200.00%', icon: Icons.calendar_today),
                  InfoCard(title: 'Activado No.', value: '05/08', icon: Icons.check_circle),
                  InfoCard(title: 'Activado Pice', value: '8069.55%', icon: Icons.insert_drive_file),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: PortfolioCard()),
                  SizedBox(width: 16),
                  Expanded(child: AdvertisingGraph()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Portafolio', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('+0.09%\n\$345,000', style: TextStyle(color: Colors.white, fontSize: 14)),
          SizedBox(height: 16),
          Text('+0.09%\n\$345,000', style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class AdvertisingGraph extends StatelessWidget {
  const AdvertisingGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Advertising', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Spend | Clicks | CPC | ROAS', style: TextStyle(color: Colors.grey)),
          Spacer(),
          Center(child: Text('Graph Placeholder', style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}*/
