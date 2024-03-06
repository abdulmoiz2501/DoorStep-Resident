import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({super.key});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: size.width* 0.06),
            ),
                Row(
                  children: [
                    Icon(
                        Icons.article_outlined,
                        size: size.height * 0.075,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: size.width*0.02,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms of Service',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                        Text(
                          'Last Updated: Feb 13, 2024',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.02,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Welcome to DoorStep! These terms outline the rules and regulations for the use of our mobile application.By accessing this app, we assume you accept these terms and conditions.',
                             style: TextStyle(
                               fontSize: size.height * 0.02,
                               fontWeight: FontWeight.normal,
                             ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          Text(
                            '1. License to Use',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'We grant you a limited, non-exclusive, non-transferable, and revocable license to use our app for personal and non-commercial purposes.You must not use the app in any way that causes, or may cause, damage to the app or impairment of the availability or accessibility of the app, or in any way which is unlawful, illegal, fraudulent, or harmful.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '2. User Accounts',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'To access certain features of the app, you may be required to create a user account. You agree to provide accurate and complete information when creating your account and to update it as needed.You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '3. Privacy',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your privacy is important to us. We collect and process personal information in accordance with our Privacy Policy, which forms part of these terms.By using our app, you consent to the collection and use of your information as described in our Privacy Policy.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '4. Prohibited Activities',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'You agree not to engage in any of the following prohibited activities:\n'
                                '- Violating any applicable laws or regulations.\n'
                                '- Interfering with or disrupting the integrity or performance of the app.\n'
                                '- Uploading or distributing any content that is unlawful, harmful, threatening, abusive, defamatory, obscene, or otherwise objectionable.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '5. Intellectual Property',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'The app and its original content, features, and functionality are owned by us and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '6. Termination',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'We may terminate or suspend your access to the app immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these terms.Upon termination, your right to use the app will cease immediately.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '7. Changes to Terms',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'We reserve the right to modify or replace these terms at any time. It is your responsibility to review these terms periodically for changes.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'If you do not agree to any of these terms you can delete your account.',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ]
            ),

          ),
      ),
    );



  }
}
