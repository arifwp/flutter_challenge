class DropDownModel {
  static String? last_selected_value;

  static String? get_last_selected_value() {
    return last_selected_value;
  }

  static void set_last_selected_value(String Value) {
    last_selected_value = Value;
    return null;
  }
}
