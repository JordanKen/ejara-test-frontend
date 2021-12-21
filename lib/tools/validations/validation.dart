class Validations {
 static String? validateName(String value) {
    if (value.isEmpty) return '\u26A0 Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if (!nameExp.hasMatch(value.trim()))
      return '\u26A0 Please enter only alphabetical characters.';
    return null;
  }

 static String? validatePhoneNumber(String value) {

    if (value.isEmpty) return '\u26A0 phone number is required';
    final RegExp nameExp = new RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    if (!nameExp.hasMatch(value.trim()))
      return '\u26A0 Please enter valid phone number';
    return null;
  }

 static String? validateEmailReg(String value) {
    if (value.isEmpty) return '\u26A0  Email is required.';
    final RegExp nameExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value.trim()))
      return '\u26A0  Invalid email address';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "\u26A0 Please Enter New Password";
    } else if (value.length < 6) {
      return "\u26A0 Password must be atleast 6 characters long";
    } else {
      return null;
    }
  }
}
