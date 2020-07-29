// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final welcomeQuestion = find.byValueKey('w');
    final b = find.byValueKey("f");
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(welcomeQuestion), "{}");
    });

    test("bp", () async {
      await driver.waitFor(b);
      await driver.tap(b);
      await driver.waitFor(find.text("done"), timeout: Duration(seconds: 10));
      print(await driver.getText(welcomeQuestion));
    });
  });
}
