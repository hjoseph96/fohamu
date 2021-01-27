import Glide from '@glidejs/glide';

document.addEventListener('DOMContentLoaded', () => {
  const sliders = document.querySelectorAll('.glide');
  if (sliders.length === 0) return;

  new Glide('.glide', {
    type: 'slider',
    keyboard: true,
    perView: 3
  }).mount()

  const galleryItems = document.querySelectorAll('.gallery-item img, .gallery-item video');
  const fullScreenGalleryEl = document.querySelector('.glide-modal');
  for (let i = 0; i < galleryItems.length; i++) {

    const showFullScreenGallery = (e) => {
      e.preventDefault();

      let el = e.target.parentNode;

      el.classList.add('selected');

      const index = [...el.parentElement.children].indexOf(el)

      const fullScreenGallery = new Glide(fullScreenGalleryEl, {
        type: 'slider',
        keyboard: true,
        perView: 1,
        startAt: index
      }).mount();
      fullScreenGalleryEl.parentNode.classList.add('show');
    };

    galleryItems[i].addEventListener('click', showFullScreenGallery);
    galleryItems[i].addEventListener('touchstart', showFullScreenGallery);
  }

  const resetVideos = () => {
    const videos = document.querySelectorAll('.glide-modal video');
    if (videos.length > 0) {
      for (let i = 0; i < videos.length; i++) {
        let video = videos[i];
        video.pause();
        video.currentTime = 0;
      }
    }
  }

  const closeModal = (e) => {
    e.preventDefault();

    const clickedPhoto = document.querySelector('.gallery-item.selected');
    clickedPhoto.classList.remove('selected');

    resetVideos();

    fullScreenGalleryEl.parentNode.classList.remove('show');
  };

  const galleryClose = document.querySelector('.gallery-modal .close');
  galleryClose.addEventListener('click', closeModal);
  galleryClose.addEventListener('touchstart', closeModal);

  const fullScreenGalleryArrows = document.querySelectorAll('.glide-modal .glide__arrow');
  for (var i = 0; i < fullScreenGalleryArrows.length; i++) {
    let arrow = fullScreenGalleryArrows[i];

    arrow.addEventListener('click', resetVideos);
    arrow.addEventListener('click', resetVideos);
  }
});
