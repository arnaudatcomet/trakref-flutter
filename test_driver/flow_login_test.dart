import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:trakref_app/constants.dart';

isPresent(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}

void main() {
  group("login test", () {
    FlutterDriver driver;
    final timeout = Duration(seconds: 120);

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('tap on login', () async {
      var usernameTextField = find.byValueKey(kUsernameKey);
      var passwordTextField = find.byValueKey(kPasswordKey);
      await driver.tap(usernameTextField);
      driver.enterText("echappell");
      await driver.tap(passwordTextField);
      driver.enterText("trakref");
      var button = find.byValueKey(kSubmitButtonKey);
      driver.tap(button);

      // Waiting for the list of account to be shown
      print("Will wait for getting key 'NetworkCircularProgressLoading'");
      await driver.waitFor(find.byValueKey(kNetworkCircularProgressLoading),
          timeout: timeout);

      final accountListView = find.byValueKey(kAccountListViewKey);
      final accountItem = find.byValueKey("${kAccountPrefixTiles}_248");
      print("Will wait for getting key 'AccountListViewKey'");
      await driver.waitFor(accountListView, timeout: timeout);

      print("Will scroll for getting key 'Cloud Compliance Real Estate'");
      // await driver.scrollIntoView(find.byValueKey("AccountListViewKey"));

      await driver.scrollUntilVisible(accountListView, accountItem,
          dyScroll: -300.0, timeout: timeout);

      driver.tap(accountItem);
      // await driver.waitFor(find.text('Cloud Compliance Real Estate'));

      print("Select the account 248 'Cloud Compliance Real Estate");
      await driver.waitFor(find.byValueKey(kMainTabKey));

      final isExists = await isPresent(find.byValueKey(kMainTabKey), driver);
      expect(isExists, true);

    }, timeout: Timeout(const Duration(minutes: 2)));

    test('tap on logout', () async {
      print("Home page loaded, now select settings");
      await driver.tap(find.byValueKey(kSettingsItemMainTabKey));

      print("Get throught the settings list");

      await driver.waitFor(find.byValueKey(kSettingsListViewKey));
      final logoutTile = find.byValueKey(kLogoutSettingsTile);
      await driver.tap(logoutTile);

      // TODO : We have to add checking that username and password are empty
      // We check if not error is displayed
      final errorLabel = find.byValueKey(kErrorMessageKey);
      final error = await driver.getText(errorLabel);
      expect(error, isEmpty);

      final loginProgressCircular = find.byValueKey(kLoginProgressCircularKey);
      final isExists = await isPresent(loginProgressCircular, driver);
      expect(isExists, false);
    });
  });
}
