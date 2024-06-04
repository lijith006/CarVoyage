import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(0, 150, 232, 19),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(0, 150, 232, 19),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            bodyText(
              'We are here to assist you! If you have any questions, suggestions, or need support, please do not hesitate to reach out to us. Your feedback is valuable, and we strive to respond promptly to all inquiries.',
            ),
            const SizedBox(height: 16),
            subHeaderText(
              'How to Reach Us',
            ),
            const SizedBox(height: 8),
            subHeaderText(
              'Customer Support',
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL('mailto:carvoyage@gmail.com'),
              child: const Text(
                'Email: carvoyage@gmail.com',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL('tel:+1234567890'),
              child: const Text(
                'Phone: 9074042965',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _launchURL('https://wa.me/1234567890'),
              child: const Text(
                'WhatsApp: 9074042965',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            bodyText(
              'Thank you for choosing Car voyage app. We look forward to serving you!',
            ),
          ],
        ),
      ),
    );
  }

  Text headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text subHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text bodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
}
