import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerUtil {
  static Future<bool> requestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
 
    bool allGranted = statuses.values.every((status) => status == PermissionStatus.granted);

    return allGranted;
  }
}
