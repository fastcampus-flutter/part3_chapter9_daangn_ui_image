import 'package:fast_app_base/common/cli_common.dart';

class Api{

  static Future<(String, DateTime)> getTitle(int id)async{
    await sleepAsync(400.ms);
    return (id.toString(), DateTime.now());
  }
}