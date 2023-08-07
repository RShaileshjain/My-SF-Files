trigger accountOpportunityUpdate on Account (before update) {
    
    If(Trigger.isbefore && Trigger.isUpdate){
        Set<Id> AccountIdSet = new Set<Id>();
        if(!trigger.new.isEmpty())
        {
        for(Account account : trigger.new)
        {
         AccountIdSet.add(account.id);   
        }
        }
        
     List<AggregateResult> totalAmountList =[SELECT AccountId, sum(Amount)opportunityAmount FROM Opportunity
                                             WHERE AccountID IN :AccountIdSet Group By AccountId];
        Map<Id,Double> totalAmoutMap = New Map<Id, Double>();
       
        if(!totalAmountList.isEmpty())
       {
           for(AggregateResult totalAmount :totalAmountList )
           {
             Id accountId = (ID)totalAmount.get('accountId');
             Double OpportunityAmount = (Double)totalAmount.get('opportunityAmount');
             totalAmoutMap.put(accountId,OpportunityAmount );  
           }
           
          List<Account>accountList = new List<Account>();
          for(Account account :trigger.new)
          {
              account.Total_Amount__c = totalAmoutMap.get(account.id);
              accountList.add(account);
          }
         
       }
        }
}
/*   for(Account account : Trigger.new)
        {
        Decimal OpportunityAmount = 0;
        
         for(Opportunity opportunity : [SELECT Name,Amount FROM Opportunity
                                       WHERE AccountId = :account.Id])
        {    
        OpportunityAmount = OpportunityAmount+opportunity.Amount;
    
        }
      
        account.Total_Amount__c = OpportunityAmount;     
        }
*/