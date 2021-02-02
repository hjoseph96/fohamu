var $ = '';
// The current card.js code does not explictly require jQuery, but instead uses the global, so this line is needed.

window.jQuery = $;
import Card from 'card';
import axios from 'axios';

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

  let cardForm = new Card({
    // a selector or DOM element for the form where users will
    // be entering their information
    form: 'form#card-form', // *required*
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
  });

  const cardValidator = require('card-validator');

  const sendPayment = (e) => {
    e.preventDefault();

    // showLoading()''

    const errorFields = document.querySelectorAll('input.error');

    if (errorFields.length > 0)
      for (let i = 0; i < errorFields.length; i ++)
        errorFields[i].classList.remove('error');

    const cardFormData = new FormData(document.querySelector('form#card-form'));
    const billingInfoFormData = new FormData(document.querySelector('form#billing-info'));
    const contactInfoFormData = new FormData(document.querySelector('form#contact-info'));

    let payload = { payment: {}, donor: {} };

    for (var [key, value] of cardFormData.entries()) {
      const input = document.querySelector(`#card-form input[name=${key}]`)

      if (value === '') {
        input.classList.add('error');
        return;
      }

      if (key === 'number') {
        const ccValidation = cardValidator.number(value)

        if (!ccValidation.isPotentiallyValid) {
          input.classList.add('error');
          return;
        }
      }

      payload['payment'][key] = value;
    }

    for (var [key, value] of billingInfoFormData.entries()) {
      const input = document.querySelector(`#card-form input[name=${key}]`)

      if (value === '' && key !== 'address2') {
        input.classList.add('error');
        return;
      }

      payload['donor'][key] = value;
    }

    for (var [key, value] of contactInfoFormData.entries()) {
      const input = document.querySelector(`#card-form input[name=${key}]`)

      if (value === '') {
        input.classList.add('error');
        return;
      }

      payload['donor'][key] = value;
    }


    let authenticityToken = document.querySelector('input[name="authenticity_token"]');
    payload["authenticity_token"] = authenticityToken.value;

    const urlParams = new URL(location.href).searchParams;
    const frequency = urlParams.get('donation[donation_type]');
    if (!['monthly', 'one_time', 'yearly'].includes(frequency))
      history.back();

    const priceInCents = parseInt(urlParams.get(`donation[${frequency}_price]`)) * 100;
    const currency = urlParams.get(`donation[${frequency}_currency]`);

    payload['donation'] = {
      frequency: frequency,
      currency: currency,
      price_in_cents: priceInCents
    }

    axios.post('/donate/process_payment', payload)
    .then(function (response) {
        const spinner = document.querySelector('.loading .cicle-loader')
        const checkmark = spinner.querySelector('.cherkmark')

        spinner.classList.add('lood-complete');
        checkmark.classList.add('show');

        setTimeout(() => { document.location.href = '/donate/sucess' }, 5000);
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      });

    const loadingOverlay = document.querySelector('.loading');
    e.target.setAttribute('disabled', true);
    loadingOverlay.classList.add('show');
  }

  const sendPaymentBtn = document.querySelector('.submit input[type="submit"]');
  sendPaymentBtn.addEventListener('click', sendPayment);

});
