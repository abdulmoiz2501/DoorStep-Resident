import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuSelectionScreen extends StatefulWidget {
  final String hallName;

  MenuSelectionScreen({required this.hallName});

  @override
  _MenuSelectionScreenState createState() => _MenuSelectionScreenState();
}

class _MenuSelectionScreenState extends State<MenuSelectionScreen> {
  String? _selectedMenu;
  final TextEditingController _guestsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Selection for ${widget.hallName}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenu('Menu #1', {
                'Starters': ['Dhai Bhalay', 'Pani Puri', 'Channa Chat'],
                'Main Course': [
                  'Chicken Boti',
                  'Lahori Chanay',
                  'Assorted Salads',
                  'Assorted Sauces',
                  'Assorted Naan & Roti'
                ],
                'Drinks': ['Soft drinks', 'Mineral Water', 'Green Tea'],
                'Desserts': ['Suji Halwa', 'Kulfi']
              }, '1000/-'),
              SizedBox(height: 20),
              _buildMenu('Menu #2', {
                'Starters': ['Salads', 'Raita', 'Fish Tikka', 'Channa Chaat', 'Dahi Barey'],
                'Main Course': [
                  'Chicken Masala Biryani',
                  'Chicken Koyla Karahi',
                  'Gola Kabab',
                  'Aalo Achari',
                  'Lahori Channay',
                  'Puri',
                  'Variety of Naan',
                  'Fresh Salads',
                  'Sauces'
                ],
                'Drinks': ['Water', 'Soft Drinks'],
                'Desserts': ['Gajar Halwa', 'Gulab Jaman']
              }, '1500/-'),
              SizedBox(height: 20),
              TextFormField(
                controller: _guestsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Guests',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of guests';
                  } else if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(String title, Map<String, List<String>> menu, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<String>(
          value: title,
          groupValue: _selectedMenu,
          onChanged: (value) {
            setState(() {
              _selectedMenu = value;
            });
          },
          title: Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            price,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menu.entries.map((entry) {
            return ExpansionTile(
              title: Text(
                entry.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              children: entry.value.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(item),
                );
              }).toList(),
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedMenu == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a menu'),
          ),
        );
        return;
      } else {
        final selectedMenu = _selectedMenu!;
        final guests = int.parse(_guestsController.text.trim());

        // Get current user
        User? user = FirebaseAuth.instance.currentUser;
        String? uid = user?.uid;

        // Get user name from 'userProfile' collection
        String? userName = await _getUserName(uid);

        // Calculate total amount
        int totalAmount = (selectedMenu == 'Menu #1') ? 1000 * guests : 1500 * guests;

        // Save booking details to Firestore
        await FirebaseFirestore.instance.collection('hall_booking').add({
          'userName': userName,
          'uid': uid,
          'hallName': widget.hallName,
          'selectedMenu': selectedMenu,
          'guests': guests,
          'totalAmount': totalAmount,
          'whenCompleted': DateTime.now(),
        }).whenComplete(() {
          print('Booking successful');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Booking successful'),
            ),
          );
        });

        // Show success message


        // Navigate back to homepage
        Navigator.pushNamed(context, '/home');
      }
    }
  }

  Future<String?> _getUserName(String? uid) async {
    if (uid == null) return null;

    DocumentSnapshot<Map<String, dynamic>> userProfileDoc =
    await FirebaseFirestore.instance.collection('userProfile').doc(uid).get();
    return userProfileDoc.exists ? userProfileDoc.get('name') : null;
  }

}
