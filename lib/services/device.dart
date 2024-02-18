import 'dart:io';

import 'package:alpha_tenders_mobile_app/dtos/Build_Info.dart';
import 'package:alpha_tenders_mobile_app/dtos/Mobile_Device.dart';
import 'package:alpha_tenders_mobile_app/models/Device.dart';
import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceService extends ChangeNotifier {

  String version;
  String appName;
  String buildNumber;
  String packageName;

  String identity;

  Map<String, dynamic> userDevice = {};

  DeviceInfo deviceInfo = DeviceInfo();
  Device device = Device();
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  BuildInfo buildInfo;

  //////////////// Singleton Constructor ///////////////////
  static final DeviceService _singleton = DeviceService._internal();

  factory DeviceService() {
    return _singleton;
  }

  DeviceService._internal();

  //////////////// Singleton Constructor ///////////////////
  
  Future getBuildInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    appName = packageInfo.appName;
    buildNumber = packageInfo.buildNumber;
    packageName = packageInfo.packageName;

    Map<String, dynamic> _buildInfo = {};

    _buildInfo['version'] = version;
    _buildInfo['appName'] = appName;
    _buildInfo['buildNumber'] = buildNumber;
    _buildInfo['packageName'] = packageName;

    buildInfo = BuildInfo.fromJson(_buildInfo);
  }

  Future<DeviceInfo> getDeviceInfo() async {
    try {
      final ipv4 = await Ipify.ipv4();
      deviceInfo.ip = ipv4;
    } catch(error) {
      print('Ipify.ipv4() error => $error');
    }
    
    device.platform = Platform.operatingSystem;

    if(Platform.isAndroid) {
      device.isAndroidApp = true;
    } else if(Platform.isIOS) {
      device.isIOSApp = true;
    }

    deviceInfo.device = device;
    return deviceInfo;
  }

  Future<MobileDevice> getUserDevice() async {
    if(buildInfo == null) {
      await getBuildInfo();
    }

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;

        identity = "${info.device}-${info.id}";

        Map<String, dynamic> _version = {};

        if (info.version != null) {
          _version['baseOS'] = info.version.baseOS;
          _version['codename'] = info.version.codename;
          _version['incremental'] = info.version.incremental;
          _version['previewSdkInt'] = info.version.previewSdkInt;
          _version['release'] = info.version.release;
          _version['sdkInt'] = info.version.sdkInt;
          _version['securityPatch'] = info.version.securityPatch;
        }

        userDevice['version'] = _version;
        userDevice['board'] = info.board.toString();
        userDevice['bootloader'] = info.bootloader.toString();
        userDevice['brand'] = info.brand.toString();
        userDevice['device'] = info.device.toString();
        userDevice['display'] = info.display.toString();
        userDevice['fingerprint'] = info.fingerprint.toString();
        userDevice['hardware'] = info.hardware.toString();
        userDevice['host'] = info.host.toString();
        userDevice['id'] = info.id.toString();
        userDevice['manufacturer'] = info.manufacturer.toString();
        userDevice['model'] = info.model.toString();
        userDevice['product'] = info.product.toString();
        userDevice['supported32BitAbis'] = info.supported32BitAbis.toString();
        userDevice['supported64BitAbis'] = info.supported64BitAbis.toString();
        userDevice['supportedAbis'] = info.supportedAbis.toString();
        userDevice['tags'] = info.tags.toString();
        userDevice['type'] = info.type.toString();
        userDevice['isPhysicalDevice'] = info.isPhysicalDevice.toString();
        userDevice['buildInfo'] = buildInfo.toMap();

      } else if (Platform.isIOS) {
        IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;

        identity = "${info.model}-${info.identifierForVendor}";

        userDevice['name'] = info.name.toString();
        userDevice['systemName'] = info.systemName.toString();
        userDevice['systemVersion'] = info.systemVersion.toString();
        userDevice['model'] = info.model.toString();
        userDevice['localizedModel'] = info.localizedModel.toString();
        userDevice['identifierForVendor'] = info.identifierForVendor.toString();
        userDevice['isPhysicalDevice'] = info.isPhysicalDevice.toString();

        Map<String, dynamic> _utsname = {};

        if (info.utsname != null) {
          _utsname['sysname'] = info.utsname.sysname;
          _utsname['nodename'] = info.utsname.nodename;
          _utsname['release'] = info.utsname.release;
          _utsname['version'] = info.utsname.version;
          _utsname['machine'] = info.utsname.machine;
        }

        userDevice['utsname'] = _utsname;

      } else {
        identity = "unknown";
      }
    } catch (error) {
      identity = "unknown";
    }

    userDevice['identity'] = identity;

    return MobileDevice.fromJson(userDevice);
  } 


}
