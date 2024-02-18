import 'package:alpha_tenders_mobile_app/dtos/Build_Info.dart';
import 'package:alpha_tenders_mobile_app/dtos/Version.dart';

class MobileDevice {
  Version version;
  BuildInfo buildInfo;
  String board;
  String bootloader;
  String brand;
  String device;
  String display;
  String fingerprint;
  String hardware;
  String host;
  String id;
  String manufacturer;
  String model;
  String product;
  String supported32BitAbis;
  String supported64BitAbis;
  String supportedAbis;
  String tags;
  String type;
  String isPhysicalDevice;
  String identity;

  MobileDevice({
    this.version,
    this.buildInfo,
    this.board,
    this.bootloader,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.hardware,
    this.host,
    this.id,
    this.manufacturer,
    this.model,
    this.product,
    this.supported32BitAbis,
    this.supported64BitAbis,
    this.supportedAbis,
    this.tags,
    this.type,
    this.isPhysicalDevice,
    this.identity,
  });

  MobileDevice.fromJson(Map<String, dynamic> json) {
    version = json['version'] != null ? Version.fromJson(json['version']) : null;
    buildInfo = json['buildInfo'] != null ? BuildInfo.fromJson(json['buildInfo']) : null;
    board = json['board'];
    bootloader = json['bootloader'];
    brand = json['brand'];
    device = json['device'];
    display = json['display'];
    fingerprint = json['fingerprint'];
    hardware = json['hardware'];
    host = json['host'];
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    product = json['product'];
    supported32BitAbis = json['supported32BitAbis'];
    supported64BitAbis = json['supported64BitAbis'];
    supportedAbis = json['supportedAbis'];
    tags = json['tags'];
    type = json['type'];
    isPhysicalDevice = json['isPhysicalDevice'];
    identity = json['identity'];
    identity = json['identity'];
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version.toMap(),
      'buildInfo': buildInfo.toMap(),
      'board': board,
      'bootloader': bootloader,
      'brand': brand,
      'device': device,
      'display': display,
      'fingerprint': fingerprint,
      'hardware': hardware,
      'host': host,
      'id': id,
      'manufacturer': manufacturer,
      'model': model,
      'product': product,
      'supported32BitAbis': supported32BitAbis,
      'supported64BitAbis': supported64BitAbis,
      'supportedAbis': supportedAbis,
      'tags': tags,
      'type': type,
      'isPhysicalDevice': isPhysicalDevice,
      'identity': identity,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (version != null) {
      data['version'] = version.toJson();
    }
    if (buildInfo != null) {
      data['buildInfo'] = buildInfo.toJson();
    }
    data['board'] = board;
    data['bootloader'] = bootloader;
    data['brand'] = brand;
    data['device'] = device;
    data['display'] = display;
    data['fingerprint'] = fingerprint;
    data['hardware'] = hardware;
    data['host'] = host;
    data['id'] = id;
    data['manufacturer'] = manufacturer;
    data['model'] = model;
    data['product'] = product;
    data['supported32BitAbis'] = supported32BitAbis;
    data['supported64BitAbis'] = supported64BitAbis;
    data['supportedAbis'] = supportedAbis;
    data['tags'] = tags;
    data['type'] = type;
    data['isPhysicalDevice'] = isPhysicalDevice;
    data['identity'] = identity;
    return data;
  }
}