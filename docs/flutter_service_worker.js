'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "e47754755251e480813b2a7fc394851f",
"version.json": "60051e3e225bcb2bbb24425acbc38353",
"index.html": "29cfe1ccb09775194df31b5cf25d7a36",
"/": "29cfe1ccb09775194df31b5cf25d7a36",
"main.dart.js": "8a2fa1774af36c4ce5dc2629908c9667",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "cd7a31e869734e249c887c0110402ae1",
"assets/AssetManifest.json": "a32cc2d31ef2306979e9243c22cda0b6",
"assets/NOTICES": "99b8d1aa308521d9d90e650897d7f854",
"assets/FontManifest.json": "c50ee0c8ff7aca97e649c1b91784cc78",
"assets/AssetManifest.bin.json": "727366ab2266b2a9617163cbef2eb475",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "594de6a8c1e5769621c70f9d1508651d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "7bb735efed33204b9d8e6afe7833ecb8",
"assets/fonts/GothamProRegular.ttf": "3100f91bbd9e9ca9ecd00255cac7d11c",
"assets/fonts/SFProText-Regular.ttf": "85bd46c1cff02c1d8360cc714b8298fa",
"assets/fonts/GothamProBold.ttf": "c15ee62b232cedc240947b6d814fb750",
"assets/fonts/MaterialIcons-Regular.otf": "9ebfc6bfa04506ca078a0099895c0174",
"assets/assets/images/alice_big_avatar.jpg": "30515091bc2b2d97a7164cfac8e204c6",
"assets/assets/images/start_screen_background.jpg": "418b815ce0497444d8fe9d7477500046",
"assets/assets/images/blur.jpg": "ed730274f86613b6cdc85710f7413bc1",
"assets/assets/images/paywall.png": "aaddbec723976ede8faff4e5d77f27ee",
"assets/assets/images/splash_icon.png": "79336bcd62ed883310a2ccb8679d5aee",
"assets/assets/images/settings_popup.png": "74a89f4c8e990e5aad13cec216b40c05",
"assets/assets/images/start_screen.png": "aca889efa01b12b3192f55d3d569c518",
"assets/assets/images/chat_avatar.png": "d232fbaf7ad275f159e3ba734e6149df",
"assets/assets/images/avatar.png": "ddcde42c29200db144e147b2f9fb7ef0",
"assets/assets/images/settings_avatar.png": "83c29e09b7879d341839579362759176",
"assets/assets/images/splash_bg.jpg": "d1aad67508fccc885c50540696781ba3",
"assets/assets/colored_icons/photography_icon.png": "994f7012cdf02f41a33929cc2f90b84e",
"assets/assets/colored_icons/intellectual_icon.png": "134caa8077037047f4728b5c313a4f1e",
"assets/assets/colored_icons/career_icon.png": "9372cf2f534edb612373bb16707986ae",
"assets/assets/colored_icons/friendly_icon.png": "ec312adb94942d293906d148cb282a76",
"assets/assets/colored_icons/art_icon.png": "7f76d9bbbead8b101569e3832375ef3a",
"assets/assets/colored_icons/health_icon.png": "84c96735edd69a5017a73ba1228fcc6c",
"assets/assets/colored_icons/sports_icon.png": "e98d48ebbdd4e314c185829802c752a4",
"assets/assets/colored_icons/gadgets_icon.png": "f97c3ee393927b185c022e74f2b134af",
"assets/assets/colored_icons/cars_icon.png": "bb818a39def8a5e4e30d3adaa13cd051",
"assets/assets/colored_icons/fashion_icon.png": "a1dab1bebd62616d1b9ba05215075f0a",
"assets/assets/colored_icons/gardening_icon.png": "69653c4ef96d977bc5b3787e642e57cb",
"assets/assets/colored_icons/animals_icon.png": "e7ab1fac082173eb62f2731bb11dc680",
"assets/assets/colored_icons/games_icon.png": "3bcf0ff1f285c29628811d8dffe8f3f3",
"assets/assets/colored_icons/music_icon.png": "2f43dbde7b1b996d5d295bd374256010",
"assets/assets/colored_icons/travel_icon.png": "71f8e8d509672d9f8656bbf94f5183b8",
"assets/assets/colored_icons/science_icon.png": "916e1cfc493d5e78121db436f7467aa4",
"assets/assets/colored_icons/movies_icon.png": "f7fc4f1946cd17c14e31ac6b12903513",
"assets/assets/colored_icons/height_icon.png": "dc1a0f49d0f1b760fc7211338e68f0e4",
"assets/assets/colored_icons/technology_icon.png": "8414b74f6fa74fb7ce0f4722f08b91a7",
"assets/assets/colored_icons/cooking_icon.png": "4826d4f1ee694f82ac456e4c151c6703",
"assets/assets/colored_icons/finance_icon.png": "daba33e3e2a1fcbf1236281db5539ad7",
"assets/assets/colored_icons/ecology_icon.png": "165f21ebfb26fd1fc6dd5886ee109571",
"assets/assets/colored_icons/literature_icon.png": "3fbb3ae44ddcd4ca39182130b59eea45",
"assets/assets/colored_icons/psychology_icon.png": "fbcc2b71dcb144790f34e83394ba75c7",
"assets/assets/intro_videos/onboarding_3.mp4": "cfd0de6f2541931f715abe2c69fc429c",
"assets/assets/intro_videos/onboarding_2.mp4": "042a5dcdda06d3dc98c0ed59d28e2111",
"assets/assets/intro_videos/onboarding_1.mp4": "a500ef12dd8ce09d0000aa2af3dfa9ae",
"assets/assets/lottie_loader.json": "291f890e1b1fa23cbad4a510d7e6d6f1",
"assets/assets/new_message.mp3": "b481efde2a0e5e563ca8b8699debd4cb",
"assets/assets/alice_photos/img4.png": "906dfa9d635e6c90309b2127afd037e8",
"assets/assets/alice_photos/img3.png": "a3d852de2d45fc67836af3a0e2f9611e",
"assets/assets/alice_photos/img2.png": "275547241d73c6615f07c7c3ff1cc568",
"assets/assets/alice_photos/img1.png": "8e8be2cd3f846362f97ab07eeae385ba",
"assets/assets/icons/arrow_down_icon.svg": "cf7b2dc654c560fa53c2d29cfeadb76e",
"assets/assets/icons/attention_icon.svg": "3b88842673c57fa4959244a64fe0cb1a",
"assets/assets/icons/settings_icon.svg": "d3fd73b977a8dcf267b83eb52d5fe64c",
"assets/assets/icons/share_icon.svg": "428fbc9a60015c4112394889f6d1a275",
"assets/assets/icons/profile_icon.svg": "766b7f899f844deead8c68498008750e",
"assets/assets/icons/gallery_icon.svg": "c1655703619fc3c4b8d128f876fb5b82",
"assets/assets/icons/lightbulb.svg": "d9f250d6fed66feff47030079e638aae",
"assets/assets/icons/left_chevron.svg": "36c0b7e726410ac415af6db49ae87b9e",
"assets/assets/icons/rate_icon.svg": "d0c7f2b3fd8d48382f10e8cc58588450",
"assets/assets/icons/pro_icon.svg": "566a145a1e5494b7805ae5158f62aba4",
"assets/assets/icons/lips_profile.svg": "15d1b33785727764a193260d5d6dff0a",
"assets/assets/icons/paywall_icon_3.png": "e55e90d176661be7cd520916311a6723",
"assets/assets/icons/arrow_up_icon.svg": "e1ca21b9174b0aad1a5a83e4a1e5da47",
"assets/assets/icons/feedback_icon.svg": "b1d1c7c44285bcaaa020c4e3351eaa76",
"assets/assets/icons/paywall_icon_2.png": "2f6417402dbdbe2f4d544937572e0939",
"assets/assets/icons/paywall_icon_1.png": "ee2f495f63b79305c9faf48fafabeb20",
"assets/assets/icons/play_icon.svg": "f5b6f145584e317e047a207a0763baca",
"assets/assets/icons/message_icon.svg": "561d8380eb6b691e0bf694889dce134e",
"assets/assets/paywall/paywall_image.png": "4cbfae6e14b439ae6ef9981cdc484e69",
"assets/assets/paywall/limits_icon.svg": "cfc9fd2c27f8a5a6b6147ec3a7a524b6",
"assets/assets/paywall/gallery_icon.svg": "6ebf0ba28e7d708db732c15d8f40c55b",
"assets/assets/paywall/pro_icon.svg": "c7a9d4d2d69821ced1fb571b98f3eb11",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
