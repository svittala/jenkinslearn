/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CARedirectToValidationPageController {
    global String ButtonMessageText {
        get;
    }
    global List<QAS_NA.EmailPhoneSObjectResult> EmailPhoneResults {
        get;
        set;
    }
    global Boolean HasAtLeastOneEmailPhoneResult {
        get;
    }
    global Boolean HasAtLeastOneResult {
        get;
    }
    global Boolean HasErrorOccured {
        get;
    }
    global Boolean HasResults1 {
        get;
    }
    global Boolean HasResults2 {
        get;
    }
    global Boolean IsAddress {
        get;
    }
    global Boolean IsEmailPhone {
        get;
    }
    global Boolean IsEmailPhoneValidation {
        get;
    }
    global Boolean IsInConsole {
        get;
        set;
    }
    global Boolean IsNewRecord {
        get;
    }
    global Boolean IsUpdated {
        get;
        set;
    }
    global String LayoutId {
        get;
    }
    global String QASToolsSmallURL {
        get;
    }
    global String RecordId {
        get;
        set;
    }
    global List<QAS_NA.CASObjectResult> Results {
        get;
        set;
    }
    global QAS_NA.CASObjectResult Results1 {
        get;
        set;
    }
    global QAS_NA.CASObjectResult Results2 {
        get;
        set;
    }
    global String RNextUrl {
        get;
    }
    global String SFSessionId {
        get;
    }
    global String SObjectLabel {
        get;
    }
    global String SObjectName {
        get;
        set;
    }
    global Boolean ValidateOnlyIfInConsoleView {
        get;
    }
    global Integer ValidationStep {
        get;
        set;
    }
    global String WarningMessage {
        get;
    }
    global CARedirectToValidationPageController() {

    }
    global CARedirectToValidationPageController(ApexPages.StandardController stdController) {

    }
    global System.PageReference DetermineRedirect() {
        return null;
    }
    global System.PageReference DoAddressValidation() {
        return null;
    }
    global System.PageReference ExecuteAddressCorrectionAndMoveNext() {
        return null;
    }
}
