import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppColors {
  static const Color bg = Colors.white;
  static const Color sectionBg = Color(0xFFF5F7FA);
  static const Color surface = Colors.white;
  static const Color primary = Color(0xFF2563EB);
  static const Color text = Color(0xFF111827);
  static const Color muted = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        fontFamily: 'MomoTrustDisplay',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bg,
          foregroundColor: AppColors.text,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark(),
      title: 'CV website',
      home: const MyHomePage(title: 'CV Design'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

PreferredSizeWidget appBarHelper({
  required BuildContext context,
  required String logoPath,
  required GlobalKey homeKey,
  required GlobalKey aboutKey,
  required GlobalKey personalKey,
  required GlobalKey projectsKey,
  required GlobalKey portfolioKey,
  required GlobalKey contactKey,
}) {
  final w = MediaQuery.of(context).size.width;

  void go(String value) {
    if (value == "Home") scrollToSection(homeKey);
    if (value == "About") scrollToSection(aboutKey);
    if (value == "Personal-Info") scrollToSection(personalKey);
    if (value == "Projects") scrollToSection(projectsKey);
    if (value == "Portfolio") scrollToSection(portfolioKey);
    if (value == "Referees") scrollToSection(contactKey);
  }

  Widget navButton(String text) {
    return TextButton(
      onPressed: () => go(text),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'MomoTrustDisplay',
          color: AppColors.primary,
        ),
      ),
    );
  }

  return AppBar(
    backgroundColor: AppColors.bg,
    elevation: 0,
    toolbarHeight: w < 700 ? 60 : 80,
    titleSpacing: 16,
    iconTheme: const IconThemeData(color: AppColors.text),
    title: Image.asset(logoPath, height: w < 700 ? 40 : 55),
    actions: [
      if (w >= 700) ...[
        navButton("Home"),
        navButton("About"),
        navButton("Personal-Info"),
        navButton("Projects"),
        navButton("Portfolio"),
        navButton("Referees"),
        const SizedBox(width: 8),
      ] else ...[
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: AppColors.text),
          onSelected: go,
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: "Home",
              child: Text(
                "Home",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
            PopupMenuItem(
              value: "About",
              child: Text(
                "About",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Personal-Info",
              child: Text(
                "Personal-Info",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Projects",
              child: Text(
                "Projects",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Portfolio",
              child: Text(
                "Portfolio",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Referees",
              child: Text(
                "Referees",
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    ],
  );
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey personalKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHelper(
        context: context,
        logoPath: 'assets/TC_logo.png',
        homeKey: homeKey,
        aboutKey: aboutKey,
        personalKey: personalKey,
        projectsKey: projectsKey,
        portfolioKey: portfolioKey,
        contactKey: contactKey,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final mobile = constraints.maxWidth < 600;
                return mobile
                    ? MobileLayout(
                        controller: _scrollController,
                        homeKey: homeKey,
                        aboutKey: aboutKey,
                        personalKey: personalKey,
                        projectsKey: projectsKey,
                        portfolioKey: portfolioKey,
                        contactKey: contactKey,
                      )
                    : DesktopLayout(
                        controller: _scrollController,
                        homeKey: homeKey,
                        aboutKey: aboutKey,
                        personalKey: personalKey,
                        projectsKey: projectsKey,
                        portfolioKey: portfolioKey,
                        contactKey: contactKey,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget section(String text, Color color, GlobalKey key) {
    return Container(
      key: key,
      height: 600,
      width: double.infinity,
      color: color.withOpacity(0.15),
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontSize: 40)),
    );
  }
}

void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final ScrollController controller;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey personalKey;
  final GlobalKey projectsKey;
  final GlobalKey portfolioKey;
  final GlobalKey contactKey;

  const DesktopLayout({
    super.key,
    required this.controller,
    required this.homeKey,
    required this.aboutKey,
    required this.personalKey,
    required this.projectsKey,
    required this.portfolioKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: <Widget>[
          Container(
            key: homeKey,
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: const HomeSite(),
          ),
          Container(
            key: aboutKey,
            alignment: Alignment.center,
            child: const AboutSite(),
          ),
          Container(
            key: personalKey,
            height: 700,
            alignment: Alignment.center,
            child: const PersonalSite(),
          ),
          Container(
            key: projectsKey,
            alignment: Alignment.center,
            height: 200,
            child: const ProjectSite(),
          ),
          Container(
            key: portfolioKey,
            alignment: Alignment.center,
            child: const PortfolioSite(),
          ),
          Container(
            key: contactKey,
            alignment: Alignment.center,
            child: const RefereeSite(),
          ),
        ],
      ),
    );
  }
}

class HomeSite extends StatelessWidget {
  const HomeSite({super.key});

  final String photo = "assets/my_image.png";

  final String FB = "assets/Facebook_Logo.png";
  final String GIT = "assets/GitHub_Logo.png";
  final String LinkedIn = "assets/Linkedin_Logo.png";
  final String Telegram = "assets/Telegram_Logo.png";

  Uri get gmailWeb => Uri.parse(
    'https://mail.google.com/mail/?view=cm&fs=1&to=chansaktry168@gmail.com',
  );

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void _contactMe() async {
    if (kIsWeb) {
      final uri = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=chansaktry168@gmail.com'
        '&su=Contact%20from%20CV%20Website'
        '&body=Hello%20Try,%0A%0AI%20saw%20your%20CV%20website%20and%20want%20to%20connect.',
      );

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not open Gmail web';
      }
    } else {
      final uri = Uri(
        scheme: 'mailto',
        path: 'chansaktry168@gmail.com',
        queryParameters: {
          'subject': 'Contact from CV Website',
          'body': 'Hello Try,\n\nI saw your CV website and want to connect.',
        },
      );

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not open email app';
      }
    }
  }

  void _openCV() {
    _launchUrl('/cv/my_cv.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Hi, I\'m ',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'MomoTrustDisplay',
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              'Try Chansak',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontFamily: 'MomoTrustDisplay',
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            Flexible(
                              child: Text(
                                'Telecommunication and Network Engineering',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                  fontSize: 25,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            Flexible(
                              child: Text(
                                'I am passionate about advancing software and network development by designing efficient, secure, and scalable solutions that solve real-world problems.',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: AppColors.muted,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            Flexible(
                              child: Text(
                                'Follow me',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: AppColors.muted,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                _launchUrl(
                                  'https://www.facebook.com/share/17rnzk3dEJ/?mibextid=wwXIfr',
                                );
                              },
                              child: SizedBox(
                                width: 25,
                                height: 50,
                                child: Image.asset(FB),
                              ),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                _launchUrl('https://github.com/Sakitsuu');
                              },
                              child: SizedBox(
                                width: 25,
                                height: 50,
                                child: Image.asset(GIT),
                              ),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                _launchUrl(
                                  'https://www.linkedin.com/in/chansak-try-4a5b66373/',
                                );
                              },
                              child: SizedBox(
                                width: 25,
                                height: 50,
                                child: Image.asset(LinkedIn),
                              ),
                            ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                _launchUrl('https://t.me/Sak_smos');
                              },
                              child: SizedBox(
                                width: 25,
                                height: 50,
                                child: Image.asset(Telegram),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 50),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                _contactMe();
                              },
                              child: Text('Contact me'),
                            ),
                            SizedBox(width: 30),
                            OutlinedButton(
                              onPressed: () {
                                _launchUrl('cv/my_cv.pdf');
                              },
                              child: Text(
                                'Download CV',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final screenW = MediaQuery.of(context).size.width;

                        final double size = screenW >= 1200
                            ? 520
                            : screenW >= 900
                            ? 420
                            : 320;

                        return SizedBox(
                          width: size,
                          height: size,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(photo),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AboutSite extends StatelessWidget {
  const AboutSite({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80),
        decoration: BoxDecoration(color: AppColors.sectionBg),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      '2+',
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      'Lab',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      'Projects',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Center(
                      child: Text(
                        'About me',
                        style: TextStyle(
                          fontFamily: 'MomoTrustDisplay',
                          fontSize: 50,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 100,
                        child: Divider(thickness: 5, color: AppColors.primary),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'My name is Try Chansak, and I am a student at the Institute of Technology of Cambodia, majoring in Telecommunication and Network Engineering. I am highly passionate about technology and have hands-on experience in development through my work in DC Lab and Fab Lab. I am committed to continuously improving my skills and knowledge and will dedicate my best efforts to ensuring the success of every project I undertake.',
                            style: TextStyle(color: AppColors.text),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'chansaktry168@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      spacing: 50,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.surface,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.teal,
                                  ),
                                  child: Icon(Icons.code),
                                ),
                                Text(
                                  'Software Development',
                                  style: TextStyle(
                                    fontFamily: 'MomoTrustDisplay',
                                    fontSize: 12,
                                    color: AppColors.text,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Turn ideas into functional applications by designing, developing, and maintaining efficient software systems that solve real-world problems.',
                                  style: TextStyle(color: AppColors.muted),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.surface,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.purple,
                                  ),
                                  child: Icon(Icons.router),
                                ),
                                Text(
                                  'Network Engineering',
                                  style: TextStyle(
                                    fontFamily: 'MomoTrustDisplay',
                                    fontSize: 12,
                                    color: AppColors.text,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Plan and implement secure, high-performance communication networks to ensure reliable data transmission and system connectivity.',
                                  style: TextStyle(color: AppColors.muted),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.surface,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.red,
                                  ),
                                  child: Icon(Icons.cell_tower),
                                ),
                                Text(
                                  'Telecommunication Systems',
                                  style: TextStyle(
                                    fontFamily: 'MomoTrustDisplay',
                                    fontSize: 12,
                                    color: AppColors.text,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Work with telecommunication systems to support wireless, wired, and digital communication solutions for real-time connectivity.',
                                  style: TextStyle(color: AppColors.muted),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalSite extends StatelessWidget {
  const PersonalSite({super.key});

  final String me = "assets/me.JPG";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            'Personal information',
            style: TextStyle(
              fontFamily: 'MomoTrustDisplay',
              fontSize: 50,
              color: AppColors.text,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 100,
              child: Divider(thickness: 10, color: AppColors.primary),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Here you can find my personal details such as my age, birthplace, and general background information.',
              style: TextStyle(color: AppColors.muted),
            ),
          ),
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 450,
                  height: 450,
                  child: Image.asset(me),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.orange,
                                ),
                                child: Icon(
                                  Icons.cake,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Date of Birth:',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                  color: AppColors.text,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '19/July/2004',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Gender:',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                  color: AppColors.text,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Male',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.pink,
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Birthplace',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                  color: AppColors.text,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Kampot',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.purple,
                                ),
                                child: Icon(
                                  Icons.location_pin,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Address',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                  color: AppColors.text,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Sola Str(371), Ou Baek K\'am, Sen Sok, Phnom Penh',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectSite extends StatelessWidget {
  const ProjectSite({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isNarrow = c.maxWidth < 1100;

        Widget stat(String big, String label) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                big,
                style: const TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(label),
            ],
          );
        }

        final left = Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.alarm, color: Colors.amber, size: 50),
            SizedBox(width: 16),
            Text(
              'In Time Projects',
              style: TextStyle(fontFamily: 'MomoTrustDisplay', fontSize: 25),
            ),
          ],
        );

        final right = Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: Colors.blue, size: 40),
            SizedBox(width: 12),
            Text('Project Done'),
          ],
        );

        if (isNarrow) {
          // Wrap = no overflow
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 40,
              runSpacing: 24,
              children: [
                left,
                stat('1+', 'Years of Experience'),
                stat('5+', 'Projects Completed'),
                stat('5+', 'Project approved'),
                right,
              ],
            ),
          );
        }

        // Wide screens keep Row layout
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(flex: 2, child: Center(child: left)),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    stat('1+', 'Years of Experience'),
                    stat('5+', 'Projects Completed'),
                    stat('5+', 'Project approved'),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Center(child: right)),
            ],
          ),
        );
      },
    );
  }
}

class PortfolioSite extends StatelessWidget {
  const PortfolioSite({super.key});

  final String about_me_web = "assets/about_me_web_design_pic.jpg";
  final String employee_management =
      "assets/employee_management_system_pic.jpg";
  final String puzzle_memory = "assets/puzzle_memory_game_pic.png";
  final String smart_home = "assets/smart_home_pic.png";
  final String smart_watering = "assets/smart_watering_system_pic.jpg";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Column(
          children: <Widget>[
            Text(
              'Portfolio',
              style: TextStyle(
                fontFamily: 'MomoTrustDisplay',
                fontSize: 50,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              child: Divider(thickness: 10, color: AppColors.primary),
            ),
            SizedBox(height: 20),
            Text(
              'I create innovative and user-friendly software and network solutions that combine functionality, creativity, and seamless user experiences.',
              style: TextStyle(color: AppColors.muted),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                        width: 300,
                        height: 900,
                        child: Column(
                          children: <Widget>[
                            Image.asset(about_me_web),
                            SizedBox(height: 20),
                            Text(
                              'About me website build with HTML',
                              style: TextStyle(
                                fontFamily: 'MomoTrustDisplay',
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                        width: 300,
                        height: 250,
                        child: Column(
                          children: <Widget>[
                            Image.asset(employee_management),
                            SizedBox(height: 20),
                            Text(
                              'Employee Management build with C & C++',
                              style: TextStyle(
                                fontFamily: 'MomoTrustDisplay',
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 710,
                        child: Column(
                          children: <Widget>[
                            Image.asset(smart_watering),
                            SizedBox(height: 20),
                            Text(
                              'Smart Watering system build with Arduino',
                              style: TextStyle(
                                fontFamily: 'MomoTrustDisplay',
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                        width: 300,
                        height: 800,
                        child: Column(
                          children: <Widget>[
                            Image.asset(puzzle_memory),
                            SizedBox(height: 20),
                            Text(
                              'Memory puzzle game build with Jave & SceneBuilder',
                              style: TextStyle(
                                fontFamily: 'MomoTrustDisplay',
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Container(
                        width: 300,
                        height: 900,
                        child: Column(
                          children: <Widget>[
                            Image.asset(smart_home),
                            SizedBox(height: 20),
                            Text(
                              'Smart Home build with ESP32 & Arduino',
                              style: TextStyle(
                                fontFamily: 'MomoTrustDisplay',
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RefereeSite extends StatelessWidget {
  const RefereeSite({super.key});

  final String GTR = "assets/gtr_logo.png";
  final String ITC = "assets/itc_logo.png";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(color: AppColors.sectionBg),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'Referees',
              style: TextStyle(
                fontFamily: 'MomoTrustDisplay',
                fontSize: 50,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 100,
                child: Divider(thickness: 10, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Lecturers are available upon request to verify my academic performance and professional conduct.',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            SizedBox(height: 50),
            Row(
              spacing: 10,
              children: <Widget>[
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 75, height: 75),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 75, height: 75),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. SRENG Sokchenda',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.phone, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '+85512407910',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'sokchenda@itc.edu.kh',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 75, height: 75),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 75, height: 75),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. THOURN Kosorl',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Deputy Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'kosorl@itc.edu.kh',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 75, height: 75),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 75, height: 75),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. MUY Sengly',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Lecture of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'muysengly@gmail.com',
                                style: TextStyle(color: AppColors.text),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  final ScrollController controller;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey personalKey;
  final GlobalKey projectsKey;
  final GlobalKey portfolioKey;
  final GlobalKey contactKey;

  const MobileLayout({
    super.key,
    required this.controller,
    required this.homeKey,
    required this.aboutKey,
    required this.personalKey,
    required this.projectsKey,
    required this.portfolioKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: <Widget>[
          Container(
            key: homeKey,
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: const MobileHome(),
          ),
          Container(
            key: aboutKey,
            alignment: Alignment.center,
            height: 1100,
            child: const MobileAbout(),
          ),
          Container(
            key: personalKey,
            height: 850,
            alignment: Alignment.center,
            child: const MobielPersonalInfo(),
          ),
          Container(
            key: projectsKey,
            alignment: Alignment.center,
            height: 200,
            child: const MobileProject(),
          ),
          Container(
            key: portfolioKey,
            height: 700,
            alignment: Alignment.center,
            child: const MobilePortfolio(),
          ),
          Container(
            key: contactKey,
            height: 400,
            alignment: Alignment.center,
            child: const MobileReferees(),
          ),
        ],
      ),
    );
  }
}

class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  final String photo = "assets/my_image.png";

  final String FB = "assets/Facebook_Logo.png";
  final String GIT = "assets/GitHub_Logo.png";
  final String LinkedIn = "assets/Linkedin_Logo.png";
  final String Telegram = "assets/Telegram_Logo.png";

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void _openCV() {
    _launchUrl('/cv/my_cv.pdf');
  }

  void _contactMe() async {
    if (kIsWeb) {
      final uri = Uri.parse(
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=chansaktry168@gmail.com'
        '&su=Contact%20from%20CV%20Website'
        '&body=Hello%20Try,%0A%0AI%20saw%20your%20CV%20website%20and%20want%20to%20connect.',
      );

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not open Gmail web';
      }
    } else {
      final uri = Uri(
        scheme: 'mailto',
        path: 'chansaktry168@gmail.com',
        queryParameters: {
          'subject': 'Contact from CV Website',
          'body': 'Hello Try,\n\nI saw your CV website and want to connect.',
        },
      );

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not open email app';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(8),
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(photo),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      Icon(Icons.waving_hand_rounded, color: Colors.amber),
                      SizedBox(width: 10),
                      Text(
                        'Hi! I\'m ',
                        style: TextStyle(
                          fontFamily: 'MomoTrustDisplay',
                          fontSize: 15,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        'Try Chansak',
                        style: TextStyle(
                          fontFamily: 'MomoTrustDisplay',
                          color: AppColors.primary,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      Text(
                        'Telecommunication and Network Engineering',
                        style: TextStyle(
                          fontFamily: 'MomoTrustDisplay',
                          fontSize: 15,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      Flexible(
                        child: Text(
                          'I am passionate about advancing software and network development by designing efficient, secure, and scalable solutions that solve real-world problems.',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            fontSize: 10,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      Text(
                        'Follow me',
                        style: TextStyle(color: AppColors.muted),
                      ),
                      Wrap(
                        children: <Widget>[
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              _launchUrl(
                                'https://www.facebook.com/share/17rnzk3dEJ/?mibextid=wwXIfr',
                              );
                            },
                            child: SizedBox(
                              width: 50,
                              height: 100,
                              child: Image.asset(FB),
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              _launchUrl('https://github.com/Sakitsuu');
                            },
                            child: SizedBox(
                              width: 50,
                              height: 100,
                              child: Image.asset(GIT),
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              _launchUrl(
                                'https://www.linkedin.com/in/chansak-try-4a5b66373/',
                              );
                            },
                            child: SizedBox(
                              width: 50,
                              height: 100,
                              child: Image.asset(LinkedIn),
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {
                              _launchUrl('https://t.me/Sak_smos');
                            },
                            child: SizedBox(
                              width: 50,
                              height: 100,
                              child: Image.asset(Telegram),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          _contactMe();
                        },
                        child: Text('Contact me'),
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {
                          _launchUrl('cv/my_cv.pdf');
                        },
                        child: Text(
                          'Download CV',
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileAbout extends StatelessWidget {
  const MobileAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 1200,
        width: 600,
        decoration: BoxDecoration(color: AppColors.sectionBg),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                'About me',
                style: TextStyle(
                  fontFamily: 'MomoTrustDisplay',
                  fontSize: 25,
                  color: AppColors.text,
                ),
              ),
              SizedBox(
                width: 75,
                child: Divider(thickness: 10, color: AppColors.primary),
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          'My name is Try Chansak, and I am a student at the Institute of Technology of Cambodia, majoring in Telecommunication and Network Engineering. I am highly passionate about technology and have hands-on experience in development through my work in DC Lab and Fab Lab. I am committed to continuously improving my skills and knowledge and will dedicate my best efforts to ensuring the success of every project I undertake.',
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'chansaktry168@gmail.com',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(8),
                      height: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.code),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Software Development',
                            style: TextStyle(
                              fontFamily: 'MomoTrustDisplay',
                              fontSize: 12,
                              color: AppColors.text,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Turn ideas into functional applications by designing, developing, and maintaining efficient software systems that solve real-world problems.',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(8),
                      height: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.router),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Network Engineering',
                            style: TextStyle(
                              fontFamily: 'MomoTrustDisplay',
                              fontSize: 12,
                              color: AppColors.text,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Plan and implement secure, high-performance communication networks to ensure reliable data transmission and system connectivity.',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(8),
                      height: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.cell_tower),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Telecommunication Systems',
                            style: TextStyle(
                              fontFamily: 'MomoTrustDisplay',
                              fontSize: 12,
                              color: AppColors.text,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Work with telecommunication systems to support wireless, wired, and digital communication solutions for real-time connectivity.',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    '2+',
                    style: TextStyle(
                      fontSize: 100,
                      fontFamily: 'MomoTrustDisplay',
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'Lab',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'MomoTrustDisplay',
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'MomoTrustDisplay',
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'MomoTrustDisplay',
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobielPersonalInfo extends StatelessWidget {
  const MobielPersonalInfo({super.key});

  final String me = "assets/me.JPG";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Personal Information',
            style: TextStyle(
              fontFamily: 'MomoTrustDisplay',
              fontSize: 25,
              color: AppColors.text,
            ),
          ),
          SizedBox(
            width: 75,
            child: Divider(thickness: 10, color: AppColors.primary),
          ),
          SizedBox(height: 25),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  'Here you can find my personal details such as my age, birthplace, and general background information.',
                  style: TextStyle(color: AppColors.muted),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 350, height: 350, child: Image.asset(me)),
            ],
          ),
          SizedBox(height: 25),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.cake),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Birth of Date:',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          '19/July/2004',
                          style: TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.person),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Gender:',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                        Text('Male', style: TextStyle(color: AppColors.muted)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.person),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Birthplace:',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          'Kampot',
                          style: TextStyle(color: AppColors.muted),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.person),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Address:',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Sola Str(371), Ou Baek K\'am, Sen Sok, Phnom Penh',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobileProject extends StatelessWidget {
  const MobileProject({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Icon(Icons.alarm, color: Colors.amber, size: 40),
                    SizedBox(width: 10),
                    Text(
                      'In Time Projects',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Project Done',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '+1',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 25,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Years of Experience',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '+5',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 25,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Project Completed',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '+5',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 25,
                        color: AppColors.text,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Project Approved',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MobilePortfolio extends StatelessWidget {
  const MobilePortfolio({super.key});
  final String about_me_web = "assets/about_me_web_design_pic.jpg";
  final String employee_management =
      "assets/employee_management_system_pic.jpg";
  final String puzzle_memory = "assets/puzzle_memory_game_pic.png";
  final String smart_home = "assets/smart_home_pic.png";
  final String smart_watering = "assets/smart_watering_system_pic.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Portfolio',
          style: TextStyle(
            fontFamily: 'MomoTrustDisplay',
            fontSize: 25,
            color: AppColors.text,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 75,
          child: Divider(thickness: 10, color: AppColors.primary),
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(width: 15),
            Flexible(
              child: Text(
                'I create innovative and user-friendly software and network solutions that combine functionality, creativity, and seamless user experiences.',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    width: 100,
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        Image.asset(about_me_web),
                        SizedBox(height: 10),
                        Text(
                          'About me website build with HTML',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    width: 100,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Image.asset(employee_management),
                        SizedBox(height: 10),
                        Text(
                          'Employee Management build with C & C++',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 250,
                    child: Column(
                      children: <Widget>[
                        Image.asset(smart_watering),
                        SizedBox(height: 10),
                        Text(
                          'Smart Watering system build with Arduino',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    width: 100,
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        Image.asset(puzzle_memory),
                        SizedBox(height: 10),
                        Text(
                          'Memory puzzle game build with Jave & SceneBuilder',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    width: 100,
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        Image.asset(smart_home),
                        SizedBox(height: 10),
                        Text(
                          'Smart Home build with ESP32 & Arduino',
                          style: TextStyle(
                            fontFamily: 'MomoTrustDisplay',
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MobileReferees extends StatelessWidget {
  const MobileReferees({super.key});

  final String GTR = "assets/gtr_logo.png";
  final String ITC = "assets/itc_logo.png";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        decoration: BoxDecoration(color: AppColors.sectionBg),
        child: Column(
          children: <Widget>[
            Text(
              'Referees',
              style: TextStyle(
                fontFamily: 'MomoTrustDisplay',
                fontSize: 25,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 75,
                child: Divider(thickness: 10, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      'Lecturers are available upon request to verify my academic performance and professional conduct.',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              spacing: 10,
              children: <Widget>[
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 25, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 25, height: 25),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 25, height: 25),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. SRENG Sokchenda',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                size: 25,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.phone,
                                size: 25,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '+85512407910',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'sokchenda@itc.edu.kh',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 25, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 25, height: 25),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 25, height: 25),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. THOURN Kosorl',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Deputy Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'kosorl@itc.edu.kh',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: AppColors.surface),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 25, color: AppColors.text),
                            Spacer(),
                            Image.asset(GTR, width: 25, height: 25),
                            SizedBox(width: 5),
                            Image.asset(ITC, width: 25, height: 25),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dr. MUY Sengly',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Lecture of Telecommunication and Network Engineering Department',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.text,
                              ),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Icon(Icons.email, color: AppColors.text),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'muysengly@gmail.com',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
