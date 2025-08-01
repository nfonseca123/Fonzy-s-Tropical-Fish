import Splide from '@splidejs/splide';

document.addEventListener('DOMContentLoaded', function () {
  const el = document.querySelector('.splide');
  if (el) {
    new Splide(el, {
      type: 'loop',
      autoplay: true,
      interval: 3000,
      pauseOnHover: true,
    }).mount();
  }
});