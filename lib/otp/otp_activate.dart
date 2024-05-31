import 'package:flutter/material.dart';

class OTPActivate extends StatefulWidget {
  const OTPActivate({super.key});

  @override
  State<OTPActivate> createState() => _OTPActivateState();
}

class _OTPActivateState extends State<OTPActivate> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController OTPCodeController = TextEditingController();
  bool isValidated = false;
  String otp = '';

  @override
  void dispose() {
    OTPCodeController.dispose();
    super.dispose();
  }

  void validateForm() {
    final form = formKey.currentState;
    if (form != null) {
      setState(() {
        isValidated = form.validate();
        otp = OTPCodeController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Row(
          children: [
            Flexible(
              child: Text(
                'Enter the activation code you received via SMS.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Icon(Icons.info_outline),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: OTPCodeController,
                      validator: (value) => validateInput(value),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'OTP',
                      ),
                      onChanged: (value) => validateForm(),
                    ),
                  ),
                  Text(
                    '${otp.length}/6',
                  ),
                ],
              ),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't receive? "),
            Text(
              "Tap here",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: isValidated
                ? () {
                    Navigator.pushNamed(
                      context,
                      '/'
                    );
                  }
                : null,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Activate',
                style: TextStyle(fontSize: 20.0),
              ),
            )),
      ],
    );
  }

  String? validateInput(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'OTP is required';
    }
    bool isNumeric = RegExp(r'^[0-9]+$').hasMatch(otp);
    bool isCorrectLength = otp.length == 6;
    if (!isNumeric) {
      return 'OTP must be numeric';
    }
    if (!isCorrectLength) {
      return 'OTP must be 6 digits long';
    }
    return null;
  }
}
