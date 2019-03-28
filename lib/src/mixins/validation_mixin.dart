class ValidationMixin {

  String validateEmail(String value) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return 'Please enter a valid email.';
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty || value.length < 6) {
      return 'You need at least 6 characters';
    }

    return null;
  }
}