/// Cloud AI is intentionally disabled until owner approval + secrets exist.
abstract final class AiConfig {
  static const cloudEnabled = false;
  static const blocker =
      'Cloud AI requires owner approval, API credentials, and privacy review. Offline Noor Teacher remains available.';
}
