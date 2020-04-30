// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Importing Desityle CSS
import 'desityle/build/css/desityle.min.css';

// Import our custom styles
import '../assets/custom.css';

// Desityle JS won't work for turbolinks, so add custom with turbolinks support
import '../assets/desityle';

// Import animate.css for adding animations
import '../assets/animate.min.css';

// Import WOW.js - library to animate while scrolling only
import WOW from 'wowjs';

// Import clipboardJS - copy the text on the go
import ClipboardJS from 'clipboard';


// Add WOW.js
const wow = new WOW.WOW();

document.addEventListener('DOMContentLoaded', function() {
  // This is right time to initialize WOW.js
  wow.init();
  
  document.addEventListener('turbolinks:load', function () {
    // Sync WOW.js on page turbolinks reload
    wow.sync();

    // Start clipboardJS
    let clipboard = new ClipboardJS('.copytoClipboard');

    // On successful clipboarding
    clipboard.on('success', function(e) {
      e.trigger.innerText = "Link copied to clipboard";
   
      e.clearSelection();
    });

    // On error clipboarding
    clipboard.on('error', function(e) {
      e.trigger.innerText = "Link could not be copied to clipboard.";

      e.clearSelection();
    });
  });
});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
