import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  print(dir);
  if (dir.endsWith('\\test')) {
    dir = dir.replaceAll('\\test', '');
  }
  if (dir.endsWith('core')) {
    print(dir);
    return File('$dir\\test\\$name').readAsStringSync();
  }
  return File('$dir\\test\\$name').readAsStringSync();
}
