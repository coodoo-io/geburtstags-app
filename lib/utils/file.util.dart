import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:android_external_storage/android_external_storage.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geburtstags_app/main.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtil {
  static final FileUtil _instance = FileUtil._internal();
  factory FileUtil() => _instance;

  FileUtil._internal() {
    // init things inside this
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile({required String name}) async {
    final path = await _localPath;
    logger.d('Local Path: $path/$name');
    return File('$path/$name');
  }

  Future<void> readBirthdays() async {
    try {
      final File file = (await _localFile(name: 'cache.json'));

      // Read the file
      final contents = await file.readAsString();
      logger.d('JSON Contents: $contents');
      List<dynamic> map;

      map = jsonDecode(contents);

      for (var value in map) {
        BirthdayRepo().insert(Birthday.fromJson(value));
      }

      return;
    } catch (e) {
      debugPrint('$e');
      return;
    }
  }

  Future<void> writeData() async {
    final file = (await _localFile(name: 'cache.json'));
    List<Birthday> birthdays = await BirthdayRepo().birthdays;
    String data = jsonEncode(birthdays.map((e) => e.toJson()).toList());
    // Write the file
    file.writeAsString(data);
    return;
  }

  /// Export my local data to a csv file

  void exportCSV() async {
    String? path;
    try {
      path = await AndroidExternalStorage.getExternalStoragePublicDirectory(DirType.downloadDirectory);
    } on PlatformException {
      path = 'Failed to get Storage Path.';
    }

    if (await Permission.storage.request().isGranted) {
      List<List<dynamic>> rows = [];
      List<dynamic> row = [];
      row.add("Name");
      row.add("Date");
      row.add("Notiz");
      rows.add(row);

      for (var element in (await BirthdayRepo().birthdays)) {
        List<dynamic> row = [];
        row.add(element.name);
        row.add(DateFormat("dd.MM.yyyy").format(element.date));
        row.add(element.notes ?? "");
        rows.add(row);
      }

      String csv = const ListToCsvConverter().convert(rows);

      File f = File("${path!}/birthdays.txt");

      f.writeAsString(csv);
    }
    return;
  }
}
