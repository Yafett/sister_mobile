// ignore_for_file: file_names

part of '../shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return _buildHomePage(context);
  }

  Widget _buildHomePage(context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHomeHeader(),
              _buildHomeBody(),
              _buildLoginButton(context),
              _buildRegisterButton(context),
              _buildTermsText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsText(context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Terms and Conditions',
            style: GoogleFonts.openSans(
              color: const Color(0xffE22426),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Privacy and Policy',
            style: GoogleFonts.openSans(
              color: const Color(0xffE22426),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Material(
          color: const Color(0xffE8E8E8),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
              Navigator.of(context).push(FadePageRoute(const RegisterPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE22426))),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                  child: Text(
                'Register',
                style: GoogleFonts.openSans(
                  color: const Color(0xffE22426),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(context) {
    return Material(
      color: const Color(0xffE22426),
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () => Navigator.of(context).push(CustomPageRoute(
          child: const RegisterPage(),
          direction: AxisDirection.right,
        )),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Center(
              child: Text(
            'Login',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildHomeBody() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.person_outlined),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in focused
            ),
            border: const UnderlineInputBorder(),
            focusColor: Colors.black,
            hintText: 'Email',
            hintStyle: GoogleFonts.openSans(),
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.lock_outline),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in focused
            ),
            border: const UnderlineInputBorder(),
            focusColor: Colors.black,
            hintText: 'Password',
            hintStyle: GoogleFonts.openSans(),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildHomeHeader() {
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
                text: 'Proceed with your\n',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
