import 'package:blott/onboarding.dart';
import 'package:blott/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class NamesScreen extends StatefulWidget {
  const NamesScreen({super.key});

  @override
  State<NamesScreen> createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isButtonEnabled = false;
  final db = Localstore.instance;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateFields);
    _lastNameController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_validateFields);
    _lastNameController.removeListener(_validateFields);
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled =
          _firstNameController.text.trim().isNotEmpty &&
          _lastNameController.text.trim().isNotEmpty;
    });
  }

  Future<void> _saveUserDetails() async {
    final user = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
    };
    await db.collection('users').doc('userDetails').set(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your legal name',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'We need to know a bit about you so that we\ncan create your account',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 24),
              CustomTextField(
                labelText: 'First name',
                controller: _firstNameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 33),
              CustomTextField(
                labelText: 'Last name',
                controller: _lastNameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 113),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isButtonEnabled ? Color(0xFF523AE4) : Colors.grey,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed:
                      _isButtonEnabled
                          ? () {
                            // _saveUserDetails();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (ctx) => Onboarding(
                                      firstName:
                                          _firstNameController.text.trim(),
                                      lastName: _lastNameController.text.trim(),
                                    ),
                              ),
                            );
                            print('Button pressed');
                          }
                          : null,
                  label: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
