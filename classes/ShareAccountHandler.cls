public class ShareAccountHandler {

    public static void afterInsert (List<Account> newTrigger )
    {
         if(!newTrigger.isEmpty())
         {
             List<AccountShare> AccountShareList = new List<AccountShare>();
             for(Account account: newTrigger)
             {
                 if(account.Share_to__c != null)
                 {
                     AccountShare accountshare = new AccountShare();
                     accountshare.UserOrGroupId=account.share_to__c;
                     accountshare.AccountId= account.Id;
                     accountshare.CaseAccessLevel='Read Only';
                     accountshare.RowCause='Manual';
                     accountshare.OpportunityAccessLevel='Read Only';
                    
                     if(account.AnnualRevenue>=5000000)                     
                       accountshare.AccountAccessLevel='Read/Write';
                     else
                       accountshare.AccountAccessLevel='Read Only';
                     
                     AccountShareList.add(accountshare);	
                 }
             }
             if(!AccountShareList.isEmpty())
             insert AccountShareList;
         }
    }
    
    public static void afterUpdate(List<Account> newTrigger, Map<Id, Account> oldAccountMap)
    {   
        
       List<AccountShare> AccountShareList = new List<AccountShare>(); 
       for(Account account : newTrigger)
       {
                     AccountShare accountshare = new AccountShare();
                     if(account.AnnualRevenue>=5000000)                     
                         accountshare.AccountAccessLevel='Read/Write';
                     else
                         accountshare.AccountAccessLevel='Read Only';
           
           AccountShareList.add(accountshare);
       }
        for(Account account : newTrigger)
        {
            Account oldAccount = oldAccountMap.get(account.Id);
            if(account.Share_To__c != oldAccount.Share_to__c)
            {
            AccountShare accountshare = new AccountShare();
            accountshare.UserOrGroupId=account.share_to__c;
                     accountshare.AccountId= account.Id;
                     accountshare.CaseAccessLevel='Read Only';
                     accountshare.RowCause='Manual';
                     accountshare.OpportunityAccessLevel='Read Only';
                     
                     if(account.AnnualRevenue>=5000000)                     
                         accountshare.AccountAccessLevel='Read/Write';
                     else
                         accountshare.AccountAccessLevel='Read Only';
                     
                     AccountShareList.add(accountshare);
            }
        }
        Upsert AccountShareList;
        
        Set<Id> AccountShareIdSet = new Set<Id>();
        for(Account newAccount : newTrigger)
        {                
            Account oldAccount = oldAccountMap.get(newAccount.Id);
            if(newAccount.Share_To__c != oldAccount.Share_to__c)
            {                
                AccountShareIdSet.add(oldAccount.Share_to__c);                
            }
        }
 
        
         Database.delete([SELECT Id, AccountId, UserOrGroupId FROM AccountShare
                          WHERE UserOrGroupId IN :AccountShareIdSet], false);
          
        
           }
}
