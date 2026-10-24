/// In-app purchase scaffolding — no live store calls without approval.
abstract final class IapScaffold {
  static const productsConfigured = false;

  static Future<String> purchaseFamilyPlus() async {
    return 'In-app purchases require store credentials and owner approval. '
        'Entitlement architecture is ready; live billing is disabled.';
  }
}
