public inherited sharing class compareRecordController {
    
    public static List<String> apiFieldNames = new List<String>(); 

    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsMethod(String objType, String fieldSet) {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objType);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSet);
        for(Schema.FieldSetMember fieldSetField : fieldSetObj.getFields()){
            apiFieldNames.add(fieldSetField.getFieldPath());
        }       
        return apiFieldNames;
    }

    @AuraEnabled(cacheable=true)
    public static List<sObject> getRecordMethod(String objType, String nameField) {
        String selectedRecordsInClause = '\'0034P00002TQ4KfQAL\',\'0034P00002TQ4KnQAL\'';
        Boolean nameExists = apiFieldNames.contains(nameField);
        String query =  'SELECT '; 
        query += nameExists ? '' : nameField + ',';
        query += String.join(apiFieldNames,',') + 
                        ' FROM ' + 
                        objType + 
                        ' WHERE Id IN (' + selectedRecordsInClause + ')';
        List<sObject> records = Database.query(query); 
        return records;
    }
}
