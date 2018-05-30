let password = document.getElementById('password');
let passwordConfirm = document.getElementById('password_confirmation');
passwordConfirm.addEventListener('keyup', checkMatching);

function checkMatching() {
    if (password.value === passwordConfirm.value) {
        passwordConfirm.classList.remove('is-invalid');
        passwordConfirm.classList.add('is-valid');
        document.getElementById('message').innerHTML = 'The passwords match';
    } else {
        passwordConfirm.classList.add('is-invalid');
        document.getElementById('message').innerHTML = 'The passwords do not match';
    }
}