
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  // Here will be the plantid key like
  static String cropIdKey = dotenv.env['CROPID_KEY'] ?? 'no hay api key';


  
}