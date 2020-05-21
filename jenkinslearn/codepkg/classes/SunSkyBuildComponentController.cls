/**
* Class Name: SunSkyBuildComponentController
* Author: SunSky 
* Date: 23-Oct-2013
* Requirement/Project Name: SunSky Toolkit
* Requirement/Project Description: This class is used to store all selected build component and associate them with a 
                                   SunSky release specified by user.
*/

public with sharing class SunSkyBuildComponentController{
   
    // Intialization of variables

    private ApexPages.StandardSetController standardController;
    public List<SunSky_Build_Component__c> selectedcomponent {get;set;}
    public SunSky_Build_Component__c comp {get;set;}
    public boolean isReady {get;set;}
    
    /**
    *   This is a constructor of the class.
    *
    *   @param standardController is a insatnce of StandardSetController and used here to get all selected components.
               comp is a instance of SunSky Build component and using this existing release to associate it with selected components.
               
    *   @Try Catch block- null
    */
    
    public SunSkyBuildComponentController(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        
        // allocating memory to comp.
        comp = new SunSky_Build_Component__c();
    }
    
      /**
    *   This is a action method to get all selected SunSky Build Components. 
        Checking that any selected build component should not have status other than "Ready for Deployment".
    *
    *   @param selectedcomponent is a insatnce list of SunSky_Build_Component__c and store all selected build components  ids.
               isReady is boolean variable.
    *   @return null - does not return any value.
    */

    public PageReference selectbuildcomp(){       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
        selectedcomponent = (List<SunSky_Build_Component__c>) standardController.getSelected();
        
        // Checking if selectedComponent list size is zero then displaying error message.
        if(selectedcomponent.size()==0)
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select atleast one record'));
       
        // Loop to traverse each build component to check the status is "Ready for deployment or not.
        for(SunSky_Build_Component__c b : [select id ,Build_Component_Status__c from SunSky_Build_Component__c where id IN: selectedcomponent] ){
            if(b.Build_Component_Status__c!='Ready For Deployment')
                isReady = true;    
        } 
        if(isReady==true)
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'All selected Build components are not ready for Deployment'));
        return null;        
    }

    /**
    *   This is a method for "Save" button. It will save the new release and associate all selected build component with existing release.  
        Changing the status of build components. 
    *
   
    *   @return to page - if all build components saved succesfully then returning to list view otherwise returning to null.
    */
    public PageReference updatebuildComp(){  
    
        // Checking user has selected existing release or not if yes then
        if(comp.SunSky_Release_Mgmt__c!=null){
            
            //soql query to get the release specified by user    
            SunSky_Release__c release = [select id from SunSky_Release__c where id=:comp.SunSky_Release_Mgmt__c]; 
            
            // Loop to traverse each selected component 
            for(SunSky_Build_Component__c b : selectedcomponent){
               
                // associate each selected build component with a existing release
                b.SunSky_Release_Mgmt__c = comp.SunSky_Release_Mgmt__c;
                
                // Changing the status of build componenets
                if(b.Build_Component_Status__c=='Ready For Deployment'){
                    b.Build_Component_Status__c='Scheduled For Release';    
                }
            }
            
            // updating selected build component and release
            update selectedcomponent;
            update release;
            return standardController.save();   
        }
        else {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select a Release.'));
            return null;
        }
    }
}