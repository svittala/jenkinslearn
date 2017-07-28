/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class Validator {
    global String ButtonMessageText {
        get;
    }
    global List<QAS_NA.EmailPhoneSObjectResult> EmailPhoneResults {
        get;
        set;
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
    global Boolean IsEmailPhoneValidation {
        get;
    }
    global Boolean IsInConsole {
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
    global Integer ValidationStep {
        get;
        set;
    }
    global String WarningMessage {
        get;
    }
    global Validator(SObject sObjectToValidate, String sObjectName, String layoutId, QAS_NA.IValidationCompleted validationCompletedHandler) {

    }
    global System.PageReference ExecuteAddressCorrectionAndMoveNext() {
        return null;
    }
    global System.PageReference Validate() {
        return null;
    }
}
