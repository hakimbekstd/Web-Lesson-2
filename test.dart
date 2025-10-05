// import 'dart:math';

// /// Funksiya ish vaqtini o'lchash uchun yordamchi
// Duration measure(Function fn, [int repeat = 10]) {
//   final sw = Stopwatch();
//   for (int i = 0; i < repeat; i++) {
//     sw.start();
//     fn();
//     sw.stop();
//   }
//   return Duration(microseconds: (sw.elapsedMicroseconds ~/ repeat));
// }

// /// Ikki yoki undan ko'p funksiyalarni taqqoslash
// void compare(Map<String, Function> functions, {int repeat = 10}) {
//   final results = <String, int>{};

//   for (final entry in functions.entries) {
//     final avg = measure(entry.value, repeat).inMicroseconds;
//     results[entry.key] = avg;
//     print('${entry.key}: ${(avg / 1000).toStringAsFixed(3)} ms (avg)');
//   }

//   // Eng tezini topish
//   final fastest = results.entries.reduce(
//       (a, b) => a.value < b.value ? a : b);

//   print('\n🔹 Eng tez kod: ${fastest.key}');
//   for (final e in results.entries) {
//     final diff = ((e.value / fastest.value) - 1) * 100;
//     print('   ${e.key} → ${(diff).toStringAsFixed(2)}% sekinroq');
//   }
// }

// void main() {
//   // Test uchun ikkita funksiya
//   compare({
//     'Loop Summation': () {
//       int s = 0;
//       for (int i = 0; i < 1000000; i++) {
//         s += i;
//       }
//     },
//     'List Reduce': () {
//       final s = List.generate(1000000, (i) => i).reduce((a, b) => a + b);
//     },
//   }, repeat: 100000);
// }



import 'dart:io';

/// Python kodni ishga tushiradi va bajarilish vaqtini o‘lchaydi
Future<int> runPython(String code) async {
  final file = File('temp.py');
  await file.writeAsString(code);

  final sw = Stopwatch()..start();
  final result = await Process.run('python', [file.path]);
  sw.stop();

  await file.delete();

  if (result.stderr.toString().isNotEmpty) {
    print("⚠️ Python Error: ${result.stderr}");
  }

  return sw.elapsedMicroseconds;
}

/// Biror funksiyani bir necha marta o‘lchash
Future<Duration> measure(Future<void> Function() fn, [int repeat = 100]) async {
  final sw = Stopwatch();
  for (int i = 0; i < repeat; i++) {
    sw.start();
    await fn();
    sw.stop();
  }
  return Duration(microseconds: sw.elapsedMicroseconds ~/ repeat);
}

/// Bir nechta kodlarni taqqoslash
Future<void> compare(Map<String, Future<void> Function()> functions,
    {int repeat = 5}) async {
  final results = <String, int>{};

  for (final entry in functions.entries) {
    final avg = (await measure(entry.value, repeat)).inMicroseconds;
    results[entry.key] = avg;
    print('${entry.key}: ${(avg / 1000).toStringAsFixed(3)} ms (avg)');
  }

  // Eng tezini topish
  final fastest =
      results.entries.reduce((a, b) => a.value < b.value ? a : b);

  print('\n🔹 Eng tez kod: ${fastest.key}');
  for (final e in results.entries) {
    final diff = ((e.value / fastest.value) - 1) * 100;
    print('   ${e.key} → ${diff.toStringAsFixed(2)}% sekinroq');
  }
}

Future<void> main() async {
  final code1 = '''
for i in range(10000):
    x = i * i
''';

  final code2 = '''
for i in range(10000):
    x = pow(i, 2)
''';

  await compare({
    'Loop multiplication': () async => await runPython(code1),
    'Pow function': () async => await runPython(code2),
  }, repeat: 3);
}
