
/****************************************************************************
 * My personal overrides                                                    *
 * All content from Optionnal-Hardening is pasted here, ENFORCED values are *
 * when I deviate from the documentations default on purpose.               *
 * version: 152                                                             *
****************************************************************************/

/****************************************************************************
 * SECTION: OPTIONAL HARDENING                                              *
****************************************************************************/
/** FIREFOX SYNC & VIEW ***/
// PREF: disable Firefox Sync
user_pref("identity.fxaccounts.enabled", true); // ENFORCED

// PREF: disable the Firefox View tour from popping up
user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");

/** PASSWORD, CREDIT CARD, AND ADDRESS MANAGEMENT ***/
// PREF: disable login manager
user_pref("signon.rememberSignons", false);

// PREF: disable address and credit card manager
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// PREF: disable passkeys
user_pref("security.webauth.webauthn", true); // ENFORCED

/** SECURE DNS ***/
// PREF: set DoH provider
user_pref("network.trr.uri", "https://dns.dnswarden.com/00000000000000000000028"); // Hagezi Normal + TIF

// PREF: enforce DNS-over-HTTPS (DoH)
user_pref("network.trr.mode", 5); // ENFORCED

/** NEW TAB SHORTCUTS ***/
// PREF: hide site shortcut thumbnails on New Tab page
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);

// PREF: hide weather on New Tab page
user_pref("browser.newtabpage.activity-stream.showWeather", false);

// PREF: hide dropdown suggestions when clicking on the address bar
user_pref("browser.urlbar.suggest.topsites", false);

/** DOWNLOADS ***/
// PREF: ask where to save every file
user_pref("browser.download.useDownloadDir", true); // ENFORCED

// PREF: ask whether to open or save new file types
user_pref("browser.download.always_ask_before_handling_new_types", false); // ENFORCED

// PREF: display the installation prompt for all extensions
user_pref("extensions.postDownloadThirdPartyPrompt", false);

/** PUBLIC KEY PINNING ***/
// PREF: enforce certificate pinning
// [ERROR] MOZILLA_PKIX_ERROR_KEY_PINNING_FAILURE
// 1 = allow user MiTM (such as your antivirus) (default)
// 2 = strict
user_pref("security.cert_pinning.enforcement_level", 2);

/** SANITIZE ON CLOSE ***/
// PREF: delete all browsing data on shutdown
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.clearOnShutdown_v2.cache", true);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false); // ENFORCED
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // ENFORCED
user_pref("privacy.clearOnShutdown_v2.downloads", true); // [HIDDEN]
user_pref("privacy.clearOnShutdown_v2.formdata", true);

// PREF: after crashes or restarts, do not save extra session data
// such as form content, scrollbar positions, and POST data
user_pref("browser.sessionstore.privacy_level", 2);

// PREF: re-enable search and form history
// This is trivial if you're sanitizing after every session.
user_pref("browser.formfill.enable", true);

/** SERVICE WORKERS ***/
// PREF: disable service workers
// This will break push notifications (blocked in Betterfox by default) and maybe other sites.
user_pref("dom.serviceWorkers.enabled", true); // ENFORCED
user_pref("dom.serviceWorkers.privateBrowsing.enabled", true); // ENFORCED

/** STORAGE ACCESS HEURISTICS ***/
// PREF: restrict dynamic storage access
// This may break SSO logins.
user_pref("privacy.restrict3rdpartystorage.heuristic.navigation", false);
user_pref("privacy.restrict3rdpartystorage.heuristic.opened_window_after_interaction", false);

/** JAVASCRIPT OPTIMIZATION ***/
// PREF: disable JIT optimization
// This removes most of the attack surface while keeping JIT compilation.
user_pref("javascript.options.ion", false);
user_pref("javascript.options.wasm_optimizingjit", false);

/** Disable DRM ***/
// PREF: disable all DRM content
user_pref("media.eme.enabled", true); // ENFORCED

// PREF: hide the UI setting
// This also disables the DRM prompt while browsing.
user_pref("browser.eme.ui.enabled", true); // ENFORCED

/** CAPTIVE PORTAL DETECTION ***/
// PREF: disable captive portal detection
// [WARNING] Do NOT use for mobile devices!
//user_pref("captivedetect.canonicalURL", ""); 
//user_pref("network.captive-portal-service.enabled", false); 
//user_pref("network.connectivity-service.enabled", false);


/****************************************************************************
 * SECTION: COMMON OVERRIDES                                                *
****************************************************************************/
/** STANDARD TRACKING PROTECTION ***/
// PREF: make Strict ETP less aggressive
user_pref("browser.contentblocking.features.strict", "tp,tpPrivate,cookieBehavior5,cookieBehaviorPBM5,cryptoTP,fp,stp,emailTP,emailTPPrivate,-consentmanagerSkip,-consentmanagerSkipPrivate,-lvl2,rp,rpTop,qps,qpsPBM,fpp,fppPrivate,btp,lna");

/** SEARCH SETTINGS ***/
// PREF: restore search engine suggestions
user_pref("browser.search.suggest.enabled", true);

/****************************************************************************
 * SECTION: UI SETTINGS                                                     *
****************************************************************************/
user_pref("zen.view.compact.enable-at-startup", true);
user_pref("zen.view.compact.hide-toolbar", true);
user_pref("zen.view.compact.toolbar-flash-popup", true);
user_pref("zen.view.use-single-toolbar", false);
user_pref("browser.translations.enable", false);
user_pref("browser.translations.automaticallyPopup", false);
user_pref("ui.key.accelKey", 224);
