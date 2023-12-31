public class CaseCountHandler {

    public static void afterInsert(List<Case> newTrigger)
    {
        
        Set<Id> accountIdSet = new Set<Id>();
        if(!newTrigger.isEmpty())
        {    
        for(Case vCase : newTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
        
        List<Account> accountList = [SELECT Id, Total_case__c,
                                    (SELECT Id FROM Cases) FROM Account
                                     WHERE Id IN :accountIdSet];
        
        for(Account account : accountList)
        {
            account.Total_case__c = account.cases.Size();
        }
        If(!accountList.IsEmpty())
            Database.update(accountList, false);

        /*Set<Id> accountIdSet = new Set<Id>();
        if(!newTrigger.isEmpty())
        {    
        for(Case vCase : newTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
        
        List<Aggregateresult> caseList =[Select Count(Id)Cases, AccountId FROM Case
                                         WHERE AccountId IN: accountIdSet Group By AccountId];
        
        Map<Id,Integer> caseIdMap = new Map<Id,Integer>();
        if(!caseList.isEmpty())
        {
            for(Aggregateresult cases : caseList)
            {
                Id accountId = (Id)cases.get('AccountId');
                Integer totalCase = (Integer)cases.get('Cases');
                caseIdMap.put(accountId,totalCase);                
            }
        }
        
        
        List<Account> accountList = [SELECT Id, Total_case__c FROM Account
                                     WHERE Id IN :accountIdSet];
        IF(!accountList.isEmpty())
        {
            for(Account account : accountList )
            {
                account.Total_Case__c = caseIdMap.get(account.Id); 
            }
        }
            Database.update(accountList,false);*/       
    } 
    
    
    public static void afterDelete(List<Case> OldTrigger)
    {
        
        Set<Id> accountIdSet = new Set<Id>();
        if(!OldTrigger.isEmpty())
        {    
        for(Case vCase : OldTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
        
        List<Account> accountList = [SELECT Id, Total_case__c,
                                    (SELECT Id FROM Cases) FROM Account
                                     WHERE Id IN :accountIdSet];
        
        
        for(Account account : accountList)
        {
            account.Total_case__c = account.cases.Size();
        }
        If(!accountList.IsEmpty())
            Database.update(accountList, false);
        
        /* Set<Id> accountIdSet = new Set<Id>();
        if(!OldTrigger.isEmpty())
        {    
        for(Case vCase : OldTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
        
        List<Aggregateresult> caseList =[Select Count(Id)Cases, AccountId FROM Case
                                         WHERE AccountId IN: accountIdSet Group By AccountId];
        
        Map<Id,Integer> caseIdMap = new Map<Id,Integer>();
        if(!caseList.isEmpty())
        {
            for(Aggregateresult cases : caseList)
            {
                Id accountId = (Id)cases.get('AccountId');
                Integer totalCase = (Integer)cases.get('Cases');
                caseIdMap.put(accountId,totalCase);                
            }
        }
        
        
        List<Account> accountList = [SELECT Id, Total_case__c FROM Account
                                     WHERE Id IN :accountIdSet];
        IF(!accountList.isEmpty())
        {
            for(Account account : accountList )
            {  
                account.Total_Case__c = caseIdMap.get(account.Id); 
            }
        }
            Database.update(accountList,false); */      
    }
    
    public static void afterUndelete(List<Case> newTrigger)
    {
        Set<Id> accountIdSet = new Set<Id>();
        if(!newTrigger.isEmpty())
        {    
        for(Case vCase : newTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
 
        
        List<Account> accountList = [SELECT Id, Total_case__c,
                                    (SELECT Id FROM Cases) FROM Account
                                     WHERE Id IN :accountIdSet];
        
        for(Account account : accountList)
        {
            account.Total_case__c = account.cases.Size();
        }
        If(!accountList.IsEmpty())
            Database.update(accountList, false);
        
        /* Set<Id> accountIdSet = new Set<Id>();
        if(!newTrigger.isEmpty())
        {    
        for(Case vCase : newTrigger )
        {
            if(vCase.AccountId != Null)
            {
              accountIdSet.add(vCase.AccountId);                   
            }
        }
        }
        
        List<Aggregateresult> caseList =[Select Count(Id)Cases, AccountId FROM Case
                                         WHERE AccountId IN: accountIdSet Group By AccountId];
        
        Map<Id,Integer> caseIdMap = new Map<Id,Integer>();
        if(!caseList.isEmpty())
        {
            for(Aggregateresult cases : caseList)
            {
                Id accountId = (Id)cases.get('AccountId');
                Integer totalCase = (Integer)cases.get('Cases');
                caseIdMap.put(accountId,totalCase);                
            }
        }
        
        
        List<Account> accountList = [SELECT Id, Total_case__c FROM Account
                                     WHERE Id IN :accountIdSet];
        IF(!accountList.isEmpty())
        {
            for(Account account : accountList )
            {
                account.Total_Case__c = caseIdMap.get(account.Id); 
            }
        }
            Database.update(accountList,false);*/
    }
    
    public static void afterUpdate(List<Case> newTrigger, Map<Id,Case> OldTriggerMap)
    {

        Set<Id> accountIdSet = new Set<Id>();
        for(Case vCase : newTrigger)
        {
            if(vCase.AccountId != null)
            {
                accountIdSet.add(vCase.AccountId);
                accountIdSet.add(OldTriggerMap.get(vCase.id).accountId);
            }
        }
        
        List<Account> accountList = [SELECT Id, Total_case__c,
                                    (SELECT Id FROM Cases) FROM Account
                                     WHERE Id IN :accountIdSet];
        
        for(Account account : accountList)
        {
            account.Total_case__c = account.cases.Size();
        }
        If(!accountList.IsEmpty())
            Database.update(accountList, false);

           /* Set<Id> accountIdSet = new Set<Id>();
        for(Case vCase : newTrigger)
        {
            if(vCase.AccountId != null)
            {
                accountIdSet.add(vCase.AccountId);
                accountIdSet.add(OldTriggerMap.get(vCase.id).accountId);
            }
        }
        
        List<Aggregateresult> caseList =[Select Count(Id)Cases, AccountId FROM Case
                                         WHERE AccountId IN: accountIdSet Group By AccountId];
        
        Map<Id,Integer> caseIdMap = new Map<Id,Integer>();
        if(!caseList.isEmpty())
        {
            for(Aggregateresult cases : caseList)
            {
                Id accountId = (Id)cases.get('AccountId');
                Integer totalCase = (Integer)cases.get('Cases');
                caseIdMap.put(accountId,totalCase);                
            }
        }
        
        
        List<Account> accountList = [SELECT Id, Total_case__c FROM Account
                                     WHERE Id IN :accountIdSet];
        IF(!accountList.isEmpty())
        {
            for(Account account : accountList )
            {
                account.Total_Case__c = caseIdMap.get(account.Id); 
            }
        }
            Database.update(accountList, false);*/       
    } 
}