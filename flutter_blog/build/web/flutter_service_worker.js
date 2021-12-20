'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "7ec804def52e3b51d4881d28de944e3c",
"favicon.ico": "6ceaa0b0b7233a7321dcdda5c2709230",
"index.html": "2eb27023c138f6188f55d4bae05e799b",
"/": "2eb27023c138f6188f55d4bae05e799b",
"css/demo.css": "477df168a3898ef570ebed29fdcc8324",
"css/husky.css": "16511976de7854e9066498c1e215ab70",
"css/normalize.css": "3bc2f546340fb700ab9a155ff6bf45ab",
"main.dart.js": "4176abd6d2003267936fb903304c0a52",
"manifest.json": "0e0a48029d39e42016ba1d68e204950d",
"assets/AssetManifest.json": "ba7ee8b442aed2505ebc370ad0bcbdb3",
"assets/NOTICES": "eb25b04976d0d662b796985062acaaa1",
"assets/FontManifest.json": "9e0649c90f16a7be3d51ab27d6089604",
"assets/packages/flutter_neumorphic/fonts/NeumorphicIcons.ttf": "32be0c4c86773ba5c9f7791e69964585",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/assets/images/blink_00.png": "59762597777cee6b3f81084e35d388fc",
"assets/assets/images/pipe_up.png": "7e59b5397c76fc3102222d43545936b0",
"assets/assets/images/blink_01.png": "a8e58893cdafaeaf4e10d9c42143fb08",
"assets/assets/images/pipe2_down.png": "7ab5a22fd71532f9682eeee493a625c4",
"assets/assets/images/land.png": "ab91509e419bff69726953e99bf22f4b",
"assets/assets/images/show.py": "c91fd5bcd13b5c4505ef524277d5b35a",
"assets/assets/images/blink_02.png": "e611d44f793a6770f0a4e27c35df07e0",
"assets/assets/images/title.png": "15977bea61fadf8c2beb3082807ea5db",
"assets/assets/images/button_resume.png": "dd48f90fe869f4098d5fab49e1d36a48",
"assets/assets/images/font_048.png": "0b190fec9e02ecd1f8100e0cc4850710",
"assets/assets/images/font_049.png": "350186f98a547f6e7cc6c3c3a650f8cb",
"assets/assets/images/brand_copyright.png": "94eb4b10c827d05d5055bf4e3412ea29",
"assets/assets/images/number_context_01.png": "3028104143d28c2ad0fffcfe51e4e34b",
"assets/assets/images/number_score_02.png": "8fea013ef904760294803c8c3e483ae6",
"assets/assets/images/bg_night.png": "8bec163be2c4f7b4ce5db8e32d674045",
"assets/assets/images/number_score_03.png": "3240e9901bec26eca36b4e88a99fd7c0",
"assets/assets/images/number_context_00.png": "57fe2f357e9f5914a32565f9c8efe10d",
"assets/assets/images/number_context_02.png": "8989607052a71bea25a7475193382687",
"assets/assets/images/number_score_01.png": "a642421ac5f31eae7d8d5912d8b615f2",
"assets/assets/images/text_game_over.png": "781352b44f3f37c5b7a480ba6a39b83f",
"assets/assets/images/number_score_00.png": "63c9cdd3016667c391ebf61094f8656f",
"assets/assets/images/number_context_03.png": "ad39e7ff27786189d93f686911c97f33",
"assets/assets/images/number_score_04.png": "905c93007422b55e234154367a000f96",
"assets/assets/images/number_context_07.png": "327bdba8ba77081b2dbca88dcb44c5af",
"assets/assets/images/black.png": "595dcd4738f545dc03a49b09ca4afac1",
"assets/assets/images/number_context_06.png": "f6a4690fbe4b2a1e13a19a0fcff3bb53",
"assets/assets/images/number_score_05.png": "63f8b9a4749c0966a870341633557b6a",
"assets/assets/images/number_score_07.png": "dc03e5fc6a01d67ded5d5ef33d47ff56",
"assets/assets/images/number_context_10.png": "9f98e84d009ad0e0914610db96d937dc",
"assets/assets/images/number_context_04.png": "05476d302c134b3d4d5daf6bf9714be0",
"assets/assets/images/text_ready.png": "840024de196da025ed7240de016eb130",
"assets/assets/images/tutorial.png": "3bd75c4b1b72f7c99b5625a456f08815",
"assets/assets/images/number_context_05.png": "1b6807f4d2c8028861de7b61e89be142",
"assets/assets/images/number_score_06.png": "622c615c7aa5a0d9374071a49c1fca2f",
"assets/assets/images/number_context_08.png": "088b6ea369310839f090211a0e1a1edb",
"assets/assets/images/button_ok.png": "bbae6995f95efa4b81d66e22b45b3c49",
"assets/assets/images/score_panel.png": "0f2cc5f13aabca3ebf6202ed8095b8b3",
"assets/assets/images/bg_day.png": "4fd392263c293e42142481b611534a1e",
"assets/assets/images/number_context_09.png": "fc1edf39b7acdb341104985c5fce70de",
"assets/assets/images/button_play.png": "c50fac1df3e0278f2ac7c1949692a2fc",
"assets/assets/images/number_score_08.png": "f1ad5ff13710b33c1f970a239c61127a",
"assets/assets/images/button_score.png": "12e7e98093e6b0b43bb6cccd39bf5a77",
"assets/assets/images/button_pause.png": "fd6fddf7a53b0700573db13e9db2037c",
"assets/assets/images/number_score_09.png": "9dcfb3b2281310050e63b967ae9d56dc",
"assets/assets/images/bird0_1.png": "077bf55c56d2d459ed427c81dc45753e",
"assets/assets/images/bird0_0.png": "28b45033553aa26b5e284dfc20859be7",
"assets/assets/images/bird2_2.png": "d2e40c6dd0b43f14c2674efad1bdb883",
"assets/assets/images/bird2_0.png": "a22d14b6e42cb4bc360ff5b9ccb2db76",
"assets/assets/images/atlas.png": "fc2e40435f47c29acf3217b55cd08b79",
"assets/assets/images/bird0_2.png": "088885330fd9a3634de0f09bd5454555",
"assets/assets/images/button_share.png": "f314d2bd35f20c101f474dc2c21e5a9b",
"assets/assets/images/new.png": "d83ed0245db8bee392ac31b3d22344c8",
"assets/assets/images/bird2_1.png": "2e3920da7f5cf8ddf3d7c08c7e6205bc",
"assets/assets/images/button_rate.png": "552efb8c064b8adc57f07deed3959990",
"assets/assets/images/medals_2.png": "6696ecb06e6dda7fa739e1d2aaba2686",
"assets/assets/images/font_050.png": "6d4b7cf300106641fa17c740a3b45f2a",
"assets/assets/images/font_051.png": "569b715450cb9f6269497d9c605a827c",
"assets/assets/images/medals_3.png": "e1d07318740e651d1e9d5ccabe9024f8",
"assets/assets/images/pipe_down.png": "a71b7837d39503fa8a6ebe90ed63b905",
"assets/assets/images/medals_1.png": "f40151f192dfd50c7da94cfea7ba30ea",
"assets/assets/images/pipe2_up.png": "7ab5a22fd71532f9682eeee493a625c4",
"assets/assets/images/font_053.png": "23ca8af727d97e98a3994bd3e1389d74",
"assets/assets/images/font_052.png": "7ce5762f765b41bdab6b084af8d656ab",
"assets/assets/images/medals_0.png": "f8b2df065a74b41dfd376357ed1f442c",
"assets/assets/images/bird1_2.png": "210cf057a797bd8976de491249647501",
"assets/assets/images/font_056.png": "b97c369d765863615842aa69df48ef46",
"assets/assets/images/font_057.png": "23219f45cb91c961c839a044ca02253e",
"assets/assets/images/white.png": "0c49c6456576f0c4f5a7e311ed4fee02",
"assets/assets/images/button_menu.png": "7d7eac72dcc6eb5b2df16dd5ce2da69b",
"assets/assets/images/bird1_1.png": "8f712cdd06176921d8dcd92edf68aa5f",
"assets/assets/images/font_055.png": "7399144a5771a94d218fd3e130509dbd",
"assets/assets/images/font_054.png": "6df650229c1d72ca0a5b7933c4004926",
"assets/assets/images/bird1_0.png": "ded023740474e6c5dea1379614d5ac38",
"assets/assets/markdown/%25E5%259F%25BA%25E4%25BA%258EViewModel%25E3%2580%2581LiveData%25E7%259A%2584%25E6%25B6%2588%25E6%2581%25AF%25E6%2580%25BB%25E7%25BA%25BFOneStepMessage.md": "ab40048893947d5bba0e326ab0d00efe"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
