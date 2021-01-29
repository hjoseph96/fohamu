var $ = '';
// The current card.js code does not explictly require jQuery, but instead uses the global, so this line is needed.

window.jQuery = $;
import Card from 'card';

document.addEventListener('DOMContentLoaded', () => {

  const donationTypes = document.querySelectorAll('input[type="radio"][name="donation[donation_type]"');

  donationTypes.forEach((radioButton, currentIndex, listObj) => {
    radioButton.addEventListener('change', (e) => {
      const selectedOption = e.target.parentElement;
      const amountForm = selectedOption.querySelector('.form');

      const selectedClasses = [...selectedOption.classList];
      const frequency = selectedClasses.filter(item => item !== 'option')[0];

      // hide other forms
      const otherForms = document.querySelectorAll(`.option:not(.${frequency}) .form`);
      otherForms.forEach((form, currentIndex, listObj) => {
        if (!form.classList.contains('hidden'))
          form.classList.add('hidden');
      });

      amountForm.classList.remove('hidden');

      const submitButton = document.querySelector('#submit-donation-type');
      if (!submitButton.classList.contains('show'))
        submitButton.classList.add('show')
    })
  });

  const form = document.querySelector('form');
  let cardForm = new Card({
    // a selector or DOM element for the form where users will
    // be entering their information
    form: 'form', // *required*
    // a selector or DOM element for the container
    // where you want the card to appear
    container: '.card-wrapper', // *required*

    // Default placeholders for rendered fields - optional
    placeholders: {
        number: '•••• •••• •••• ••••',
        name: 'Full Name',
        expiry: '••/••',
        cvc: '•••'
    },
    // if true, will log helpful messages for setting up Card
    debug: true // optional - default false
  });
});
