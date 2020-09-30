import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4Dev'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  Future<void> _loadPage(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashPage()),
        ],
      ),
    );
  }

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await _loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
