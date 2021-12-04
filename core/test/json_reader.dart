import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    // dir = dir.replaceAll('/test', '');
    return File('$dir/$name').readAsStringSync();
  }
  if (dir.endsWith('core')) {
  return File('$dir/test/$name').readAsStringSync();
  }
  if (dir.endsWith('search')) {
  return File('$dir/test/$name').readAsStringSync();
  }
  return File('$dir/test/$name').readAsStringSync();
}
