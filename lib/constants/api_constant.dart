class ApiConstants {
  static const String baseUrl = "https://bsmdemo.shesoft.com.pk";

  static const String signUpUrl = "$baseUrl/api/ReportExecl/SendOTP";
  static const String loginUrl = "$baseUrl/api/ReportExecl/login";
  static const String getProjectUrl = "$baseUrl/api/MobileAPi/GetProjects";
  static const String getBlockUrl = "$baseUrl/api/MobileApi/GetBlockByProject";
  static const String getPlotSizeUrl = "$baseUrl/api/MobileApi/GetPlotSize";
  static const String addBookingUrl = "$baseUrl/api/MobileApi/Booking";
  static const String getCustomerPortalUrl = "$baseUrl/api/ReportExecl/GetStamentByID";
  static const String getCompanyInfoUrl = "$baseUrl/api/ReportExecl/GetCompanyInfo";
  static const String getBranchUrl = "$baseUrl/api/ReportExecl/GetBranch";
  static const String getStatementUrl = "$baseUrl/api/ReportExecl/GetStamentByReg_no";

  static const String getPlotNatureUrl = "$baseUrl/api/MobileApi/GetPlotNature";
  static const String getPlotTypeUrl = "$baseUrl/api/MobileApi/GetPlotType";
  static const String getEventsUrl = "$baseUrl/api/ReportExecl/GetCompanyInfo";
}
