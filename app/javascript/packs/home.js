import Glide from '@glidejs/glide';

document.addEventListener('DOMContentLoaded', () => {

  new Glide('.glide', {
    type: 'slider',
    keyboard: true,
    perView: 3
  }).mount()
});
