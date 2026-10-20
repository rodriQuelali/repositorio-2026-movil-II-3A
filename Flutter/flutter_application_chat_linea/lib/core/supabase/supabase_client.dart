import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://lzhidjieasuumwmtiopu.supabase.co',
      anonKey: 'sb_publishable_PU4UGpztvbh5mSSutvG0RQ_lAQr-_Bq',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}