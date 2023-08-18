import 'package:passtop/services/encryption_services.dart';

import 'imports/packages_imports.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;
const uuid = Uuid();
final encryptionServices = EncryptionServices();
