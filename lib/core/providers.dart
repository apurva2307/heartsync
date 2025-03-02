import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_messaging/constants/constants.dart';

final appwriteClientProvider = Provider((ref) {
  final Client client = Client()
      .setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
      .setProject(
        AppwriteConstants.projectID,
      ) // Your project ID// Your project ID
      .setSelfSigned(status: true);
  return client;
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});

final appwriteStorageProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Storage(client);
});

final appwriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Realtime(client);
});
