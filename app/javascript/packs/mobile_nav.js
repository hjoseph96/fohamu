document.addEventListener('DOMContentLoaded', () => {

  const burgerIcon = document.querySelector('.pwa-hamburgerMenu4');

  const toggleMobileMenu = (e) => {
    const menu = document.querySelector('.navbar .mobile .menu');

    if (burgerIcon.classList.contains('open')) {
      burgerIcon.classList.remove('open');
      menu.classList.remove('show');
    } else {
      burgerIcon.classList.add('open');
      menu.classList.add('show');
    }
  };

  burgerIcon.addEventListener('click', toggleMobileMenu);
});
