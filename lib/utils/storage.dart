import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = Logger('tool');

/// 获得指定的 key
Future<T?> getKey<T>(String key) =>
    SharedPreferences.getInstance().then((instance) => instance.get(key) as T);

/// 获得指定的 int key
Future<int?> getIntKey(String key) =>
    SharedPreferences.getInstance().then((instance) => instance.getInt(key));

/// 获得指定的 String key
Future<String?> getStringKey(String key) =>
    SharedPreferences.getInstance().then((instance) => instance.getString(key));

/// 获得指定的 bool key
Future<bool?> getBoolKey(String key) =>
    SharedPreferences.getInstance().then((instance) => instance.getBool(key));

/// 获得指定的 double key
Future<double?> getDoubleKey(String key) =>
    SharedPreferences.getInstance().then((instance) => instance.getDouble(key));

/// 获得指定的 List<String> key
Future<List<String>?> getStringListKey(String key) =>
    SharedPreferences.getInstance()
        .then((instance) => instance.getStringList(key));

/// 设置指定的 key
Future<void> setKey(String key, dynamic value) =>
    SharedPreferences.getInstance().then((instance) {
      final type = value.runtimeType.toString();

      switch (type) {
        case 'bool':
          instance.setBool(key, value as bool);
          break;

        case 'int':
          instance.setInt(key, value as int);
          break;
        case 'double':
          instance.setDouble(key, value as double);
          break;
        case 'String':
          instance.setString(key, value as String);
          break;
        case 'List<String>':
          instance.setStringList(key, value as List<String>);
          break;

        default:
          _logger.warning('Can not set key $key of type $type.');
      }
    });

/// 设置指定的 int key
Future<void> setIntKey(String key, int value) =>
    SharedPreferences.getInstance().then((instance) {
      instance.setInt(key, value);
    });

/// 设置指定的 String key
Future<void> setStringKey(String key, String value) =>
    SharedPreferences.getInstance().then((instance) {
      instance.setString(key, value);
    });

/// 设置指定的 bool key
// ignore: avoid_positional_boolean_parameters
Future<void> setBoolKey(String key, bool value) =>
    SharedPreferences.getInstance().then((instance) {
      instance.setBool(key, value);
    });

/// 设置指定的 double key
Future<void> setDoubleKey(String key, double value) =>
    SharedPreferences.getInstance().then((instance) {
      instance.setDouble(key, value);
    });

/// 设置指定的 List<String> key
Future<void> setStringListKey(String key, List<String> value) =>
    SharedPreferences.getInstance().then((instance) {
      instance.setStringList(key, value);
    });
