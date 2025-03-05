import 'package:proximity_sensor/proximity_sensor.dart';

class ProximitySensorService {
  Stream<bool> get proximityStream async* {
    await for (var event in ProximitySensor.events) {
      // Depending on the event value, return true or false
      bool isNear = event == 1; // If event is 1, the device is near
      yield isNear;
    }
  }
}
