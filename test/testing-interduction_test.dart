// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/testing-interduction.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
