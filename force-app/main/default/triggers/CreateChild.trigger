trigger CreateChild on Opportunity (after insert, after update) {
    Map<ID,Opportunity> parentOpps = new Map<ID,Opportunity>();
    Set<Id> listIds = new Set<Id>();

    for (Opportunity childObj : Trigger.new) {
        listIds.add(childObj.OpportunityId);
    }

    parentOpps = new Map<Id,Opportunity>([SELECT Id, Insurance_Lines__c FROM Opportunity WHERE ID IN :listIds]);

    List<Opportunity> childOpp = new List<Opportunity>();

    for (Opportunity opp:parentOpps.values()) {
        List<String> strType = new List<String>();

        for (Opportunity oppty:opp.Opportunities) {
            strType.add(oppty.Insurance_Lines__c);
        }

        opp.Insurance_Lines__c = String.join(strType, ',');
    }

    update parentOpps.values();
}