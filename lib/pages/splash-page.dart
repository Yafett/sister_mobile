// ignore_for_file: file_names

part of '../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplashPage(context);
  }

  Widget _buildSplashPage(context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: 1000,
        duration: 2500,
        splash: _buildSplashBackground(context),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
      )
    );
  }

  Widget _buildSplashBackground(context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xffE22426),
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage('assets/images/splash-background.jpg')),
      ),
      child: _buildSplashText(),
    );
  }

  Widget _buildSplashText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/smi-logo-white.png'),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'SISTER MOBILE\n',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'set up your future',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
