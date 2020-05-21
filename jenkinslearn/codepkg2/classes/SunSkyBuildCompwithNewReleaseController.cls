/**
* Class Name: SunSkyBuildCompwithNewReleaseController
* Author: SunSky 
* Date: 23-Oct-2013
* Requirement/Project Name: SunSky Toolkit
* Requirement/Project Description: This class will get the selected SunSky build component from list view and associate
                                   them with a new created release. According to the status of selected build component change status as well.   
*/


public with sharing class SunSkyBuildCompwithNewReleaseController{

    // Intialization of variables
    private ApexPages.StandardSetController standardController;
    public List<SunSky_Build_Component__c> selectedcomponent {get;set;}
    public SunSky_Release__c release {get;set;}
    public String userName {get;set;}
    public boolean isReady {get;set;}
    
    /**
    *   This is a constructor of the class.
    *
    *   @param standardController is a insatnce of StandardSetController and used here to get all selected components.
               release is a instance of SunSky_Release__c and using this for creating new release to associate it with selected components.
               userName is string variable and used to store the owner of new created release.
    *   @Try Catch block- to handle the soql query of getting current logged in user
    */
  
    public SunSkyBuildCompwithNewReleaseController(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        
        // allocationg memory to SunSky release instance.
        release = new SunSky_Release__c();
        
        // SOQL query to get the current logged in user name.
        try{
            USer u = [select firstName,LastName from user where id =:Userinfo.getUserId()];
            userName = u.FirstName+' '+u.LastName;           
        }catch(System.QueryException e){}
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
        
        // If size of selected build components is zero then display page message.
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
    *   This is a method for "Save" button. It will save the new release and associate all selected build component with new release.  
        Changing the status of build components. 
    *
   
    *   @return to page - if all build components saved succesfully then returning to list view otherwise returning to null.
    */


    public PageReference updatebuildComp(){  
        // If release is not null then saving new release in database.
        if(release!=null){                
                insert release;
         
            // Loop traverse on each build component
            for(SunSky_Build_Component__c b : selectedcomponent){
                
                // associating newn created release with selected build component.
                b.SunSky_Release_Mgmt__c = release.id;
            
                // Changing the status of build componenets
                if(b.Build_Component_Status__c=='Ready For Deployment'){
                    b.Build_Component_Status__c='Scheduled For Release';    
                }
            }
            
            // updating selected build components and release.
            try{
                update selectedcomponent;
                upsert release;
            }catch(Exception e){}
            
            return standardController.save();   
            }
            else {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter details of a Release.'));
                return null;
            }
    }
}