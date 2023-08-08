/*  When an account/accounts inserted with a custom lookup field with  sharing user (Share_to__c);
it create sharing rule

And updating account with annual revenue change rights and updating user delete previous record and save new record.*/

trigger ShareAccountRecord on Account (After insert, After update) {

    if(trigger.isAfter && trigger.isInsert)
    {
        ShareAccountHandler.afterInsert(trigger.new);
    }
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        
        integer count = 0;
        for(Account newAccount : trigger.new)
        {    
            Account oldAccount = trigger.oldMap.get(newAccount.Id);
            if((newAccount.AnnualRevenue != oldAccount.AnnualRevenue)||
               (newAccount.Share_To__c != oldAccount.Share_to__c))
            {                
                count++;
            }
        }
        if(count>0)
        {
          ShareAccountHandler.afterUpdate(trigger.new, trigger.oldmap);
            
        }                   

    }
}