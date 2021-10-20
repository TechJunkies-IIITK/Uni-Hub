
class Verifier{

  static final phoneRegex = RegExp(r'\d{10}');

  static final otpRegex = RegExp(r'\d{6}');

  static final emailRegex = RegExp(r'\w+(@iiitkottayam\.ac\.in)?');

  static bool isPhone(String input) => phoneRegex.stringMatch(input) == input;

  static bool isEmail(String input) => emailRegex.stringMatch(input) == input;

  static bool isOTP(String input) => otpRegex.stringMatch(input) == input;

}