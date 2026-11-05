// Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
(function () {
  function init() {
    var el = document.getElementById('castle-map-viewer');
    if (!el || typeof OpenSeadragon === 'undefined') {
      return;
    }
    var viewer = OpenSeadragon({
      id: 'castle-map-viewer',
      prefixUrl: '',
      tileSources: '../images/castle-map.dzi',
      background: '#000000',
      showNavigationControl: false,
      showNavigator: true,
      navigatorPosition: 'BOTTOM_RIGHT',
      navigatorAutoFade: false,
      navigatorSizeRatio: 0.18,
      visibilityRatio: 0.8,
      constrainDuringPan: true,
      homeFillsViewer: false,
      minZoomImageRatio: 0.4,
      maxZoomPixelRatio: 2,
      immediateRender: true,
      animationTime: 0.3,
      imageSmoothingEnabled: false,
      gestureSettingsMouse: {
        clickToZoom: false,
        dblClickToZoom: true,
        flickEnabled: true
      }
    });
    viewer.addHandler('open', function () {
      var viewport = viewer.viewport;
      viewport.panTo(new OpenSeadragon.Point(0.5, 0.5), true);
      viewport.zoomTo(viewport.imageToViewportZoom(1), null, true);
    });
    if (viewer.drawer && viewer.drawer.setImageSmoothingEnabled) {
      viewer.drawer.setImageSmoothingEnabled(false);
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
