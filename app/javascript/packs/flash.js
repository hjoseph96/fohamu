document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.flash').forEach((flash) => {
    setTimeout(() => {
      flash.classList.add('flash-hide');
    }, 5000);
  });
});
