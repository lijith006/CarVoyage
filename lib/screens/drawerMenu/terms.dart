import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

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
          'Terms and Conditions ',
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
            headerText(
              'Introduction',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Welcome to Car Voyage. By using our services, you agree to be bound by these Terms and Conditions . If you do not agree to these Terms, please do not use our services.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Rental Agreement',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Requirements\n- Renters must be at least 18 years old.\n- Renters must possess a valid driver\'s license.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Responsibilities\n- The renter is responsible for the vehicle during the rental period.\n- The renter must return the vehicle in the same condition as it was rented.\n- The renter must comply with all local traffic laws and regulations.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Duration\n- The rental period begins when the renter takes possession of the vehicle and ends when the vehicle is returned to the designated location.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Prohibited Uses\n- The vehicle may not be used for illegal activities.\n- The vehicle may not be driven by anyone other than the renter without the Company\'s permission.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Payment Terms',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Methods\n- We accept the following payment methods:Offline & Gpay.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Insurance and Liability',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Coverage\n- The Company provides insurance coverage as follows: Normal car insurance.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Liability\n- The renter is liable for any damage or loss that occurs during the rental period.\n- In the event of an accident, the renter must notify the Company immediately and follow the provided procedures.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Privacy Policy',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Data Collection\n- We collect and store personal information as described in our Privacy Policy.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'User Rights\n- Users have the right to access, modify, and delete their personal data. For more information, please refer to our Privacy Policy.',
            ),
            const SizedBox(height: 8),
            bodyText(
              'Data Protection\n- We implement security measures to protect user data from unauthorized access and use.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Termination',
            ),
            const SizedBox(height: 8),
            bodyText(
                'Either party may terminate the rental agreement under the following conditions: \n 1. Violation of Terms: Either party can terminate the agreement if the other party violates any terms and conditions specified in the rental agreement .'
                '\n 2. Non-payment: If the renter fails to make the required payment , the rental agreement can be terminated by the rental company.'
                '\n 3. Unauthorized Driver: The agreement can be terminated if the car is driven by someone who is not authorized to drive it according to the rental agreement.'
                '\n 4. Illegal Use: The rental company can terminate the agreement if the car is used for illegal activities or purposes not specified in the rental agreement.'),
            const SizedBox(height: 16),
            headerText(
              'Governing Law',
            ),
            const SizedBox(height: 8),
            bodyText(
              'These Terms are governed by the laws of Jurisdiction. Any disputes arising from these Terms will be resolved in the courts of Jurisdiction.',
            ),
            const SizedBox(height: 16),
            headerText(
              'Contact Information',
            ),
            const SizedBox(height: 8),
            bodyText(
              'For support or inquiries, please contact us at carvoyage@gmail.com.',
            ),
            const SizedBox(height: 16),
            bodyText(
              'By using our services, you acknowledge that you have read, understood, and agree to these Terms and Conditions.',
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
