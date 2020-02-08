// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// styles
import './../main-app/styles/application.scss'; // import styles

require('./../main-app/js/application'); // import javascripts

require.context('../images', true); // import all static images
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)