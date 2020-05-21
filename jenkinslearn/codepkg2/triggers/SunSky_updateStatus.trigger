/**
* Trigger Name: SunSkyBuildComponentController
* Author: SunSky 
* Date: 23-Oct-2013
* Requirement/Project Name: SunSky Toolkit
* Requirement/Project Description: Trigger will update the status of a build component on update and insert of release
*/


trigger SunSky_updateStatus on SunSky_Release__c 
            (after update, after insert) {

    // Set to store the ids of release which are inserting or updating
    Set<id> releaseIds = new Set<id>();  
    
    // For loop to traverse each release
    for(SunSky_Release__c r: Trigger.New){
        
        // if status of release is "Scheduled" or "Deployed" then
        if(r.Release_Status__c== 'Scheduled' || r.Release_Status__c== 'Deployed')
           releaseIds.add(r.id); // storing ids in set  
    }
    
    // If there is any release with status "Scheduled" or "Deployed" then
    if(releaseIds.size()>0){
    
       List<SunSky_Build_Component__c> compList = new List<SunSky_Build_Component__c>();
        
        try{
            compList = [select id, name,Build_Component_Status__c,SunSky_Release_Mgmt__r.Release_Status__c from SunSky_Build_Component__c where SunSky_Release_Mgmt__c IN: releaseIds];
        }catch(system.queryException e){}  
        
        // for loop to traverse on each build component
        for(SunSky_Build_Component__c b : compList){
            
            //If status of build component related release is "Scheduled" then change the  status of build component to "Scheduled For Release"          
            if(b.SunSky_Release_Mgmt__r.Release_Status__c == 'Scheduled'){
                b.Build_Component_Status__c= 'Scheduled For Release' ;
            }
            //If status of build component related release is "Deployed" then change the  status of build component to "Deployed" 
            if(b.SunSky_Release_Mgmt__r.Release_Status__c == 'Deployed'){
                b.Build_Component_Status__c= 'Deployed' ;
            }
        }
        
        // If list size is greater than zero
        if(compList.size()>0){
            // update build component list
            upsert compList;  
        }
    }
}