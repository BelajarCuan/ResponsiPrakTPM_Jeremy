import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadTerbaru() {
    return BaseNetwork.get("terbaru");
  }

  Future<Map<String, dynamic>> loadInternasional() {
    return BaseNetwork.get("internasional");
  }

  Future<Map<String, dynamic>> loadIslam() {
    return BaseNetwork.get("islam");
  }

  Future<Map<String, dynamic>> loadDaerah() {
    return BaseNetwork.get("daerah");
  }
}
