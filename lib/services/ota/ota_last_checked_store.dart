/// Local-only persistence of when the parent last ran "Check for updates"
/// (ADR 0017).
///
/// A single millisecond-epoch timestamp in SharedPreferences. It is written
/// only when a check actually reached the content server and got a valid,
/// signed manifest (up-to-date / available / incompatible), so "never on this
/// device" stays truthful until a real check happens. The value is NEVER sent
/// on the wire and is not child data, so it adds no egress and no new
/// backup-exposure surface beyond the prefs store the app already uses.
library;

import 'package:shared_preferences/shared_preferences.dart';

class OtaLastCheckedStore {
  OtaLastCheckedStore({SharedPreferences? prefs}) : _override = prefs;

  static const String _key = 'ota.last_checked_at_ms';

  final SharedPreferences? _override;
  SharedPreferences? _cached;

  Future<SharedPreferences> _prefs() async =>
      _cached ??= _override ?? await SharedPreferences.getInstance();

  /// The instant of the last server-reached check, or null if none has happened
  /// on this device.
  Future<DateTime?> read() async {
    final ms = (await _prefs()).getInt(_key);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> write(DateTime when) async {
    await (await _prefs()).setInt(_key, when.millisecondsSinceEpoch);
  }
}
