// app/javascript/plugins/init_star_rating.js
// import "jquery-bar-rating";

// const initFavoutite = () => {
//   $('#favourite').barrating({
//     theme: 'css-stars'
//   });
// };





const whiteHeart = '\u2661';
const blackHeart = '\u2665';
const button = document.querySelector('button');
button.addEventListener('click', toggle);

function toggle() {
  const like = button.textContent;
  if(like==whiteHeart) {
    button.textContent = blackHeart;
  } else {
    button.textContent = whiteHeart;
  }
}

export { toggle };