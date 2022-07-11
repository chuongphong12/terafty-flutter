import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:terafty_flutter/models/storage_item.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await _secureStorage.read(key: 'access_token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
      key: newItem.key,
      value: newItem.value,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}
