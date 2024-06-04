import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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
          'About Us ',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            subHeaderText('Welcome to Car Voyage'),
            const SizedBox(height: 8),
            bodyText(
              'At Car Voyage, we are dedicated to providing top-notch car rental services to make your travel experience seamless and enjoyable. Our goal is to offer you the best vehicles, exceptional customer service, and unbeatable prices.',
            ),
            const SizedBox(height: 16),
            subHeaderText('Our Mission'),
            const SizedBox(height: 8),
            bodyText(
              'Our mission is to simplify the car rental process and offer a wide range of high-quality vehicles to meet the diverse needs of our customers. We strive to:',
            ),
            const SizedBox(height: 8),
            bodyText(
              '- Provide a hassle-free rental experience with transparent pricing.\n- Ensure the safety and comfort of our customers through regular vehicle maintenance and inspection.\n- Deliver excellent customer service and support throughout the rental period.',
            ),
            const SizedBox(height: 16),
            subHeaderText('Our Fleet'),
            const SizedBox(height: 8),
            bodyText(
              'We offer a diverse fleet of vehicles to cater to various preferences and requirements. Whether you need a compact car for city driving, a spacious SUV for a family trip, or a luxury car for a special occasion, we have got you covered. All our vehicles are well-maintained, clean, and equipped with the latest features to ensure a smooth and enjoyable ride.',
            ),
            const SizedBox(height: 16),
            subHeaderText('Why Choose Us?'),
            const SizedBox(height: 8),
            bodyText(
              '- Convenience: Easy booking process through our user-friendly app.\n- Affordability: Competitive rates with no hidden fees.\n- Variety: A wide selection of vehicles to choose from.\n- Safety: Regularly serviced and inspected vehicles for your peace of mind.',
            ),
            const SizedBox(height: 16),
            subHeaderText('Our Commitment'),
            const SizedBox(height: 8),
            bodyText(
              'At Car Voyage, we are committed to maintaining the highest standards of service and customer satisfaction. We continuously strive to improve our services and offerings based on your feedback and needs.',
            ),
            const SizedBox(height: 16),
            subHeaderText('Contact Us'),
            const SizedBox(height: 8),
            bodyText(
              'If you have any questions, suggestions, or feedback, please do not hesitate to contact us. We are here to help and ensure you have a fantastic car rental experience with us.',
            ),
            const SizedBox(height: 8),
            bodyText(
              '- Email: carvoyage@gmail.com',
            ),
            const SizedBox(height: 16),
            bodyText(
              'Thank you for choosing Car Voyage! We look forward to serving you.',
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
