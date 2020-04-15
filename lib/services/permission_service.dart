import 'package:permission_handler/permission_handler.dart';

class PermissionService{

    final PermissionHandler _permissionHandler = PermissionHandler();

   Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }
  Future<bool> requestLocationPermission(Function onPermissionDenied) async {
    var granted = await _requestPermission(PermissionGroup.locationAlways);
    if(!granted){
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> hasLocationPermission() async {
    return hasPermission(PermissionGroup.locationAlways);
  }
  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

}