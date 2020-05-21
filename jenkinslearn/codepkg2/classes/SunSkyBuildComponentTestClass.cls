/**
* Class Name: SunSkyBuildComponentTestClass
* Author: SunSky 
* Date: 23-Oct-2013
* Requirement/Project Name: SunSky Toolkit
* Requirement/Project Description: This class is test class of SunSkyBuildComponentController, SunSkyBuildCompwithNewReleaseController classes and covers a trigger called "SunSky_updateStatus".     
*/



@isTest 
private class SunSkyBuildComponentTestClass {
    static testMethod void validateSunSkyBuildComponentTestClass() {
    
    List<SunSky_Build_Component__c> compList = new List<SunSky_Build_Component__c>();
    
    Account acc = new Account();
    acc.name='testAccount';
    acc.rating='Hot';
    insert acc;
    
    Contact con = new Contact();
    con.firstname = 'Test';
    con.lastname = 'Test';
    con.accountid =acc.id;    
    insert con;
    
    SunSky_Requirement__c req = new SunSky_Requirement__c();
    req.Raised_By_Contact__c = con.id;
    req.Requirement_Description__c = 'it is a testing record';
    req.Requirement_Priority__c = 'High';
    req.Raised_On_Date__c=date.today();
    req.Functional_Type__c='Data';
    req.Requirement_Status__c = 'Approved';
    insert req;
    
    SunSky_Build_Component__c comp = new SunSky_Build_Component__c();
    comp.SunSky_Requirement__c = req.id;
    comp.Build_Component_Type__c = 'All';
    comp.Build_Component_Description__c = 'testing component';
    comp.Build_Component_Status__c ='Ready For Deployment';
    insert comp;
    
    SunSky_Build_Component__c compo = new SunSky_Build_Component__c();
    compo.SunSky_Requirement__c = req.id;
    compo.Build_Component_Type__c = 'All';
    compo.Build_Component_Description__c = 'testing component two';
    compo.Build_Component_Status__c ='Ready For Deployment';
    insert compo;
    
    compList.add(comp);
    compList.add(compo);
    
    SunSky_Release__c release = new SunSky_Release__c();
    release.Release_Description__c = 'It is test release';
    release.Release_Approver_Contact__c=con.id;
    release.Release_Date__c = date.today();
    release.Release_Status__c ='Scheduled';
    insert release;
    
    test.startTest();
    
    ApexPages.StandardSetController controller = new ApexPages.StandardSetController(compList);
    SunSkyBuildComponentController stdController = new SunSkyBuildComponentController (controller);
    
    SunSkyBuildCompwithNewReleaseController stdController1 = new   SunSkyBuildCompwithNewReleaseController (controller);
        
    stdController1.release.Release_Description__c = 'It is test release';
    stdController1.release.Release_Approver_Contact__c=con.id;
    stdController1.release.Release_Date__c = date.today();
    stdController1.release.Release_Status__c ='Scheduled';
    stdController1.selectbuildcomp();
    stdController1.selectedcomponent.add(comp);
    stdController1.selectedcomponent.add(compo);
    stdController1.updatebuildComp(); 
    
    stdController.comp.SunSky_Release_Mgmt__c = release.id;
    stdController.selectbuildcomp();
    stdController.selectedcomponent.add(comp);
    stdController.selectedcomponent.add(compo);
    stdController.updatebuildComp();
   
   
    update release;
    
    release.Release_Status__c ='Deployed';
    update release; 
    test.StopTest();
    }
}