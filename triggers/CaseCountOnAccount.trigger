trigger caseCountTrigger on Case (After insert,After update,After delete,After undelete) {
    trigger__c triggerStatus = Trigger__c.getInstance('caseCountTrigger');
    
    if(triggerStatus.Is_Active__c){
        
    if(trigger.isAfter && trigger.isInsert)
    {
       CaseCountHandler.afterInsert(trigger.new);
    }      
    
    
    if(trigger.isafter && trigger.isDelete)
    {
     CaseCountHandler.afterDelete(Trigger.old);
    }                    
    
    If(trigger.isAfter && trigger.isUndelete)
    {
      CaseCountHandler.afterUndelete(Trigger.new);
    }
    
    If(trigger.isAfter && trigger.isUpdate)
    {   
        integer count = 0;
        for(Case newCaseList : trigger.new)
        {    
            Case oldCaseList = trigger.oldMap.get(newCaseList.Id);
            if(newCaseList.AccountId != oldCaseList.AccountId)
            {                
                count++;
            }
        }
        if(count>0)
        {
          CaseCountHandler.afterUpdate(trigger.new, trigger.oldmap);
            
        }                   
    }
    }
}