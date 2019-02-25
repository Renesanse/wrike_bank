
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bank/main.dart';

void main() {
  final app = MyHomePage();
  test("100", () {
    var money = 5;
    var banknotes = [1,2];
    expect(app.bag(banknotes: banknotes, money: money),{2:2,1:1});
  });
}
