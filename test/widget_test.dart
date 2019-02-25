
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bank/main.dart';

main() {
  final app = MyHomePage();
  test("100", () {
    var money = 100;
    var banknotes = [10,20,5,1];
    expect(app.bag(banknotes: banknotes, money: money),{20:4,10:1,5:1,1:5});
  });
  test("66", () {
    var money = 66;
    var banknotes = [7,5,8];
    expect(app.bag(banknotes: banknotes, money: money),{8:6,7:1,5:2});
  });
}
