import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // Force dark mode
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Full dark background
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
        ),
      ),
      title: 'CV website',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        fontFamily: 'MomoTrustDisplay',
      ),
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

class _MyHomePageState extends State<MyHomePage> {
  String logo_TC = 'assets/TC_logo.png';

  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey personalKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            SizedBox(width: 75, height: 75, child: Image.asset(logo_TC)),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => scrollToSection(homeKey),
            child: const Text(
              "Home",
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(aboutKey),
            child: const Text(
              "About",
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(personalKey),
            child: Text(
              'Personal-Info',
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(projectsKey),
            child: const Text(
              "Projects",
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(portfolioKey),
            child: Text(
              'Portfolio',
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
          TextButton(
            onPressed: () => scrollToSection(contactKey),
            child: const Text(
              "Referees",
              style: TextStyle(fontFamily: 'MomoTrustDisplay'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              height: 600,
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
              height: 1146,
              alignment: Alignment.center,
              child: const PortfolioSite(),
            ),
            Container(
              key: contactKey,
              height: 500,
              alignment: Alignment.center,
              child: const RefereeSite(),
            ),
          ],
        ),
      ),
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

class HomeSite extends StatelessWidget {
  const HomeSite({super.key});

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

  void viewCv() {
    final url = '${html.window.location.origin}/cv/my_cv.pdf';
    final viewerUrl = 'https://docs.google.com/viewer?url=$url';
    html.window.open(viewerUrl, '_blank');
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
                                color: Colors.blue,
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
                                  color: Colors.grey,
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
                                  color: Colors.grey,
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
                                backgroundColor: Colors.purple[600],
                              ),
                              onPressed: () {
                                viewCv();
                              },
                              child: Text('View CV'),
                            ),
                            SizedBox(width: 30),
                            OutlinedButton(
                              onPressed: () {
                                _launchUrl('cv/my_cv.pdf');
                              },
                              child: Text('Download CV'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(8),
                            width: 750,
                            height: 750,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(photo),
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
        height: 550,
        decoration: BoxDecoration(color: Color(0xFF0E0F1A)),
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
                      ),
                    ),
                    Text(
                      'Lab',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
                      ),
                    ),
                    Text(
                      'Projects',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
                      ),
                    ),
                    Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'MomoTrustDisplay',
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
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 100,
                        child: Divider(thickness: 5, color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'My name is Try Chansak, and I am a student at the Institute of Technology of Cambodia, majoring in Telecommunication and Network Engineering. I am highly passionate about technology and have hands-on experience in development through my work in DC Lab and Fab Lab. I am committed to continuously improving my skills and knowledge and will dedicate my best efforts to ensuring the success of every project I undertake.',
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'chansaktry168@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                              color: Colors.black,
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
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Turn ideas into functional applications by designing, developing, and maintaining efficient software systems that solve real-world problems.',
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
                              color: Colors.black,
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
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Plan and implement secure, high-performance communication networks to ensure reliable data transmission and system connectivity.',
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
                              color: Colors.black,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.red[900],
                                  ),
                                  child: Icon(Icons.cell_tower),
                                ),
                                Text(
                                  'Telecommunication Systems',
                                  style: TextStyle(
                                    fontFamily: 'MomoTrustDisplay',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Work with telecommunication systems to support wireless, wired, and digital communication solutions for real-time connectivity.',
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
            style: TextStyle(fontFamily: 'MomoTrustDisplay', fontSize: 50),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 100,
              child: Divider(thickness: 10, color: Colors.blue),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Here you can find my personal details such as my age, birthplace, and general background information.',
              style: TextStyle(color: Colors.grey),
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
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '19/July/2004',
                                style: TextStyle(color: Colors.grey),
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
                                  Icons.home,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Gender:',
                                style: TextStyle(
                                  fontFamily: 'MomoTrustDisplay',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Male',
                                style: TextStyle(color: Colors.grey),
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
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Kampot',
                                style: TextStyle(color: Colors.grey),
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
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Sola Str(371), Ou Baek K\'am, Sen Sok, Phnom Penh',
                                style: TextStyle(color: Colors.grey),
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
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.alarm, color: Colors.amber, size: 50),
                SizedBox(width: 20),
                Text(
                  'In Time Projects',
                  style: TextStyle(
                    fontFamily: 'MomoTrustDisplay',
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              spacing: 100,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '1+',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 35,
                      ),
                    ),
                    Text('Years of Experience'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '5+',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 35,
                      ),
                    ),
                    Text('Projects Completed'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '5+',
                      style: TextStyle(
                        fontFamily: 'MomoTrustDisplay',
                        fontSize: 35,
                      ),
                    ),
                    Text('Project approved'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.blue, size: 40),
                SizedBox(width: 20),
                Column(children: <Widget>[Text('Project Done'), Text('')]),
              ],
            ),
          ),
        ],
      ),
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
      child: Column(
        children: <Widget>[
          Text(
            'Portfolio',
            style: TextStyle(fontFamily: 'MomoTrustDisplay', fontSize: 50),
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            child: Divider(thickness: 10, color: Colors.blue),
          ),
          SizedBox(height: 20),
          Text(
            'I create innovative and user-friendly software and network solutions that combine functionality, creativity, and seamless user experiences.',
            style: TextStyle(color: Colors.grey),
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
                            style: TextStyle(fontFamily: 'MomoTrustDisplay'),
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
                            style: TextStyle(fontFamily: 'MomoTrustDisplay'),
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
                            style: TextStyle(fontFamily: 'MomoTrustDisplay'),
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
                            style: TextStyle(fontFamily: 'MomoTrustDisplay'),
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
                            style: TextStyle(fontFamily: 'MomoTrustDisplay'),
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
        height: 500,
        decoration: BoxDecoration(color: Color(0xFF0E0F1A)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'Referees',
              style: TextStyle(fontFamily: 'MomoTrustDisplay', fontSize: 50),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 100,
                child: Divider(thickness: 10, color: Colors.blue),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Lecturers are available upon request to verify my academic performance and professional conduct.',
                style: TextStyle(color: Colors.grey),
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
                    decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.account_balance)),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.phone)),
                            SizedBox(width: 5),
                            Flexible(child: Text('+85512407910')),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.email)),
                            SizedBox(width: 5),
                            Flexible(child: Text('sokchenda@itc.edu.kh')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Deputy Head of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.account_balance)),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.email)),
                            SizedBox(width: 5),
                            Flexible(child: Text('kosorl@itc.edu.kh')),
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
                    decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 50),
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Lecture of Telecommunication and Network Engineering Department',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.account_balance)),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Institute of Technology of Cambodia',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(child: Icon(Icons.email)),
                            SizedBox(width: 5),
                            Flexible(child: Text('muysengly@gmail.com')),
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
