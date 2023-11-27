class CountryPhoneCode {
  String name;
  String code;

  CountryPhoneCode(this.name, this.code);

  static List<CountryPhoneCode> countryCodes = [
    CountryPhoneCode('Vietnam', '+84'),
    CountryPhoneCode('United Kingdom', '+44'),
    CountryPhoneCode('Australia', '+61'),
    CountryPhoneCode('India', '+91'),
    CountryPhoneCode('South Africa', '+27'),
    CountryPhoneCode('Singapore', '+65'),
  ];
}
