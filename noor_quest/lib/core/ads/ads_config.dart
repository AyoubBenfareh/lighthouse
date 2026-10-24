/// Ads abstraction — always disabled for children in this build.
abstract final class AdsConfig {
  static const enabled = false;
  static const blocker =
      'Ads interface is stubbed and disabled by default. Do not enable without Families policy review.';
}
