class Links {
  // current url
  static String currentBaseUrl = 'https://www.lurp.it';
  static String currentBaseUrlShort = 'https://lurp.it';
  static String currentDomain = 'www.lurp.it';
  static String currentDomainShort = 'lurp.it';

  // flutter app
  static String appUrl = 'https://www.lurp.it/a';

  // static website
  static String staticSiteBaseUrl = 'https://www.lurp.it';
  static String staticSiteHomeUrl = 'https://www.lurp.it/home';

  // legal
  static String privacyUrl = 'https://www.lurp.it/docs/privacy-policy';
  static String termsUrl = 'https://www.lurp.it/docs/terms-of-service';
  static String guidelinesUrl = 'https://www.lurp.it/docs/community-guidelines';
  static String disclaimerUrl = 'https://www.lurp.it/docs/content-disclaimer';

  // socials
  static String instagramUrl = 'https://www.lurp.it/instagram';
  static String tiktokUrl = 'https://www.lurp.it/tiktok';
  static String twitterUrl = 'https://www.lurp.it/twitter';
  static String facebookUrl = 'https://www.lurp.it/facebook';
  static String linkedinUrl = 'https://www.lurp.it/linkedin';

  // miscellaneous websites
  static const supportUrl = 'https://www.lurp.it/support';
  static const accountUrl = 'https://www.lurp.it/account';
  static const donationUrl = 'https://www.lurp.it/donate';
  static const usernameInfoUrl = 'https://wopuff.com/account/username';
  static const accountInfoUrl = 'https://wopuff.com/account/about';

  // emails
  static const supportEmail = 'help@wopuff.com';
  static const contactEmail = 'hi@wopuff.com';

  static void setProdMode(bool isProd) {
    if (isProd) {
      currentBaseUrl = 'https://www.lurp.it';
      currentBaseUrlShort = 'https://lurp.it';
      currentDomain = 'www.lurp.it';
      currentDomainShort = 'lurp.it';
      appUrl = 'https://www.lurp.it/a';
    } else {
      currentBaseUrl = 'https://preview.lurp.it';
      currentBaseUrlShort = 'https://preview.lurp.it';
      currentDomain = 'preview.lurp.it';
      currentDomainShort = 'preview.lurp.it';
      appUrl = 'https://preview.lurp.it';
    }
  }
}
