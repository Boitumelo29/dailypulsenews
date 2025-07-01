class Validation {
  static String? emailValidation(String? value) {
    if (value == null ||
        value.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return "Email is not valid";
    }
    return null;
  }


  static String? usersEmailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is not valid";
    }
    return null;
  }
  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is not valid";
    } else if (value.length <= 5) {
      return "Password must be longer than 6 characters";
    }
    return null;
  }

  static String? cellphoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Cellphone number is not valid";
    } else if (value.length <= 9) {
      return "Cellphone must be 10 digits";
    }
    return null;
  }


  static String? passwordConformValidation(
      String? value, String? confirmValue) {
    if (value == null || value.isEmpty) {
      return "Password is not valid";
    } else if (value != confirmValue) {
      return "Password does not match";
    }
    return null;
  }

  static String? usernameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "First name is empty";
    } else if (value.length <= 2) {
      return "First name must be longer than 2 characters";
    }
    return null;
  }
  static String? lastnameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Lastname is empty";
    } else if (value.length <= 2) {
      return "Lastname must be longer than 2 characters";
    }
    return null;
  }

  static String? textValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Text-field is empty";
    }
    return null;
  }
}
