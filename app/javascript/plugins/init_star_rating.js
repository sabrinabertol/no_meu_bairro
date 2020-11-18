// app/javascript/plugins/init_star_rating.js
import "jquery-bar-rating";

const initStarRating = () => {
  $('#review_rating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
