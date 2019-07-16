// API Constants
final String apiKey = "eyJJbnN0YW5jZUlEIjoxMzgsIlRva2VuIjoiTWF4aW1vIiwiR3JhbnREYXRlIiwiMjAxNS0wMS0xNCIsIkV4cGlyZURhdGUiOiIyMDM1LTEyLTMxIn0=";
final String baseURL = "https://api.trakref.com/v3.21";
final String loginURL = "$baseURL/login";
final String accountsURL = "$baseURL/accounts";

// POST Messages Constants
const String kAddCylinderSuccessfulMessage = "A cylinder has been successfully added.";
const String kAddServiceEventSuccessfulMessage = "A service event has been successfully added.";
const String kAddServiceEventErrorMessage = "Something wrong happened, please retry a bit later.";

// LABEL Keys Constants
const String kErrorMessageKey = "ErrorMessageKey";

// TEXTFIELDS Keys Constants
const String kUsernameKey = "UsernameKey";
const String kPasswordKey = "PasswordKey";

// BUTTONS Keys Constants
const String kSubmitButton = "SubmitButton";

// LIST Keys Constants
const String kAccountListViewKey = "AccountListViewKey";
const String kSettingsListViewKey = "SettingsListViewKey";

// TILES Keys Constants
const String kAccountPrefixTiles = "account_tile";
const String kLogoutSettingsTile = "LogoutSettingsTile";

// TABS Keys Constants
const String kMainTabKey = "MainTabKey";
const String kHomeItemMainTabKey = "HomeItemMainTabKey";
const String kSearchItemMainTabKey = "SearchItemMainTabKey";
const String kAddItemMainTabKey = "AddItemMainTabKey";
const String kSettingsItemMainTabKey = "SettingsItemMainTabKey";

// FORMS Keys Constants
const String kNetworkCircularProgressLoading = "NetworkCircularProgressLoading";
const String kEquipmentWorkedOnKey = "EquipmentWorkedOnKey";
const String kEquipmentWorkedOn = "Equipment worked on";
const String kTypeOfServiceKey = "TypeOfServiceKey";
const String kTypeOfService = "Type of service";
const String kLeakDetectionMethodKey = "LeakDetectionMethodKey";
const String kLeakDetectionMethod = "Leak detection method";
const String kWasLeakFoundKey = "WasLeakFoundKey";
const String kWasLeakFound = "Was leak found?";
const String kServiceDateKey = "ServiceDateKey";
const String kServiceDate = "Service date";
const String kCauseOfLeakKey = "CauseOfLeakKey";
const String kCauseOfLeak = "Cause of leak";
const String kInitialLeakCategoryKey = "InitialLeakCategoryKey";
const String kInitialLeakCategory = "Leak category";
const String kInitialLeakLocationKey = "InitialLeakLocationKey";
const String kInitialLeakLocation = "Leak location";
const String kVerificationLeakCategoryKey = "VerificationLeakCategoryKey";
const String kVerificationLeakCategory = "Leak category";
const String kVerificationLeakLocationKey = "VerificationLeakLocationKey";
const String kVerificationLeakLocation = "Leak location";
const String kVerificationDateKey = "VerificationDateKey";
const String kVerificationDate = "Verification date";
const String kVerificationLeakMethodKey = "VerificationDateKey";
const String kVerificationLeakMethod = "Verification leak method";
const String kVerificationWasLeakFoundKey = "VerificationWasLeakFoundKey";
const String kVerificationWasLeakFound = "Was leak found during follow up inspection";
const String kVerificationLeakCauseKey = "VerificationLeakCauseKey";
const String kVerificationLeakCause = "Verification cause of leak";
const String kEstimatedLeakAmountKey = "EstimatedLeakAmountKey";
const String kEstimatedLeakAmount = "Estimated leak amount";
const String kFollowUpDateKey = "FollowUpDateKey";
const String kFollowUpDate = "Follow up date";
const String kShutdownServiceActionKey = "ShutdownServiceActionKey";
const String kServiceAndLeakRepairServiceActionKey = "ServiceAndLeakRepairServiceActionKey";
const String kServiceAndLeakRepairServiceTransferReasonKey = "ServiceAndLeakRepairServiceTransferReasonKey";
const String kServiceAction = "Service action";
const String kTransferReason = "Transfer reason";
const String kWasVacuumPulledKey = "WasVacuumPulledKey";
const String kWasVacuumPulled = "Was vacuum pulled?";
const String kDepthOfVacuumKey = "DepthOfVacuumKey";
const String kDepthOfVacuum = "Depth of vacuum";
const String kPostShutdownStatusKey = "kPostShutdownStatusKey";
const String kPostShutdownStatus = "Post shutdown status";
const String kLeakRepairStatusKey = "LeakRepairStatusKey";
const String kLeakRepairStatus = "Leak repair status";
const String kObservationNotesKey = "ObservationNotesKey";
const String kObservationNotes = "Notes: ";
const String kSubmitButtonKey = "SubmitButtonKey";
const String kLoginProgressCircularKey = "LoginProgressCircularKey";

// Constante for datetime
const String kShortReadableDateFormat = "EEEE d MMMM, yyyy";
const String kShortDateFormat = "yyyy-MM-dd";
const String kShortTimeDateFormat = "yyyy-MM-dd'T'HH:mm:ss";