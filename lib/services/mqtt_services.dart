import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final MqttServerClient client;

  MqttService(String identifier)
      : client = MqttServerClient('broker.hivemq.com', identifier); // Use seu broker MQTT

  Future<void> connect() async {
    client.setProtocolV311();
    try {
      await client.connect();
    } catch (e) {
      print('Erro ao conectar: $e');
      client.disconnect();
    }
  }

  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  void disconnect() {
    client.disconnect();
  }
}
