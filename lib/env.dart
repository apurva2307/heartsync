import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'env/.env', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: 'APPWRITE_ENDPOINT', obfuscate: true)
  static String appwriteEndpoint = _Env.appwriteEndpoint;
  @EnviedField(varName: 'APPWRITE_PROJECTID', obfuscate: true)
  static String appwriteProjectID = _Env.appwriteProjectID;
  @EnviedField(varName: 'APPWRITE_DATABASEID', obfuscate: true)
  static String appwriteDatabaseID = _Env.appwriteDatabaseID;
  @EnviedField(varName: 'APPWRITE_USERS_COLLECTIONID', obfuscate: true)
  static String appwriteUsersCollectionID = _Env.appwriteUsersCollectionID;
}
