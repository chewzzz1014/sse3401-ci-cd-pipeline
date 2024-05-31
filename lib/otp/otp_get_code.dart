import 'package:flutter/material.dart';
import './otp_main.dart';

class OTPGetCode extends StatefulWidget {
  const OTPGetCode({super.key});

  @override
  State<OTPGetCode> createState() => _OTPGetCodeState();
}

class _OTPGetCodeState extends State<OTPGetCode> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  bool isValidated = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    super.dispose();
  }

  void validateForm() {
    final form = formKey.currentState;
    if (form != null && form.validate() && isChecked) {
      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
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
                'Enter your mobile number to activate your account.',
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
              flex: 1,
              child: Row(
                children: [
                  Image.asset(
                    'images/mys.png',
                    width: 48,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: const Text('+60'),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: phoneNumberController,
                  validator: (value) => validateInput(value),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter phone number',
                  ),
                  onChanged: (value) => validateForm(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                final form = formKey.currentState;
                setState(() {
                  isChecked = value!;
                  isValidated = isChecked && form!.validate();
                });
              },
            ),
            const Text('I agree to terms & conditions'),
          ],
        ),
        ElevatedButton(
          onPressed: isValidated
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPMain(step: 2),
                    ),
                  );
                }
              : null,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Get Activation Code',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }

  String? validateInput(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }
    bool isNumeric = RegExp(r'^[0-9]+$').hasMatch(phoneNumber);
    bool isCorrectLength = phoneNumber.length == 9 || phoneNumber.length == 10;
    if (!isNumeric) {
      return 'Phone number must be numeric';
    }
    if (!isCorrectLength) {
      return 'Phone number must be 9 or 10 digits long';
    }
    return null;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.blue;
  }
}
