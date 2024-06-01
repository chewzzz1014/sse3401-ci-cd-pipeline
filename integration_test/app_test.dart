import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/otp/otp_get_code.dart';
import 'package:lab5/otp/otp_main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  testWidgets('OTPGetCode widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: OTPGetCode(),
      ),
    ));

    // Verify if the widget is rendered
    expect(find.byType(OTPGetCode), findsOneWidget);

    // Verify if the initial state is correct
    expect(find.text('Enter your mobile number to activate your account.'), findsOneWidget);
    expect(find.text('+60'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);

    // Enter phone number into TextFormField
    await tester.enterText(find.byType(TextFormField), '123456789');

    // Tap the Checkbox
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verify if Checkbox is checked
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    // Verify if the ElevatedButton is enabled after entering a phone number and checking the checkbox
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isTrue);

    // Tap the ElevatedButton
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify if the navigation to OTPMain widget is triggered after tapping the ElevatedButton
    expect(find.byType(OTPMain), findsOneWidget);
  });
}