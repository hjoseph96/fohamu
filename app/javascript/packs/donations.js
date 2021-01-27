document.addEventListener('DOMContentLoaded', () => {

  const donationTypes = document.querySelectorAll('input[type="radio"][name="donation_type"');

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
    })
  });
});
