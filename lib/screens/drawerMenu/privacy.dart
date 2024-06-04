import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/home_screen.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(0, 150, 232, 19),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(5, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView(
          children: [
            Text(
              'Privacy Policy for CarVoyage\n\n'
              'CarVoyage is dedicated to safeguarding the privacy and security of your personal information. '
              'This Privacy Policy outlines how we collect, use, and protect the information you provide to us through our mobile application.\n\n',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            _buildSectionTitle(
              'Information We Collect',
            ),
            _buildBulletPoint(
              'Personal Information: When you create an account with us, we may collect personal details such as your name, email address, phone number, and payment information.',
            ),
            _buildBulletPoint(
              'Location Information: With your consent, we may gather precise location data to offer location-based services, including finding nearby rental locations.',
            ),
            _buildBulletPoint(
              'Usage Data: We collect data about how you interact with our app, such as the features you use, pages you visit, and actions you take.',
            ),
            _buildBulletPoint(
              'Device Information: We may collect information about your device, including device type, operating system, and unique device identifiers.',
            ),
            _buildSectionTitle('How We Use Your Information'),
            _buildBulletPoint(
              'Service Provision: To process your bookings, facilitate rental transactions, and deliver the services you request.',
            ),
            _buildBulletPoint(
              'Personalization: To customize your experience and provide tailored content, recommendations, and offers based on your preferences and usage patterns.',
            ),
            _buildBulletPoint(
              'Service Improvement: To analyze usage trends, track app performance, and identify areas for enhancement.',
            ),
            _buildBulletPoint(
              'Communication: To communicate with you about your bookings, account status, promotions, and updates to our services.',
            ),
            _buildSectionTitle('Data Sharing'),
            _buildBulletPoint(
              'Service Providers: We may share your information with service providers who assist us in operating our app, processing payments, and providing support services.',
            ),
            _buildBulletPoint(
              'Business Partners: We may share your information with trusted business partners to offer co-branded services, promotions, or special offers.',
            ),
            _buildBulletPoint(
              'Legal Compliance: We may disclose your information in response to legal requests or regulatory requirements, or to protect our rights, property, or safety.',
            ),
            _buildSectionTitle('Data Security'),
            _buildBulletPoint(
              'We employ reasonable measures to protect the security and confidentiality of your personal information. '
              'We utilize industry-standard encryption and security technologies to safeguard your data from unauthorized access, disclosure, alteration, or destruction.',
            ),
            _buildSectionTitle('Your Choices and Rights'),
            _buildBulletPoint(
              'You have certain rights regarding your personal information, including the right to access, correct, or delete your data. '
              'You can manage your preferences and update your information through the app settings or by contacting us directly.',
            ),
            _buildSectionTitle('Updates to This Privacy Policy'),
            _buildBulletPoint(
                'We may update this Privacy Policy periodically to reflect changes in our practices or legal requirements. '),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(115, 50, 49, 49),
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_box_outlined),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
