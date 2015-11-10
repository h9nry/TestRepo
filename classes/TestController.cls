public class TestController {
    
    public Map<String,String> selectedValues{ get; set; }
    public List<String> selValues {
        get {
            return selectedValues.values();
        }
        set;
    }
    
    public Component.Apex.PageBlockSection getContactPageBlockSection()   
    {
        String objectName = 'Account';
        Map<string, Schema.SObjectField> FieldMap;
        FieldMap = Schema.SObjectType.Account.fields.getMap();
        Set<string> FieldSet = FieldMap.keySet();
        List<string> FieldList = new List<string>();
        FieldList.addAll(FieldSet);
        FieldList.sort();
        Component.Apex.PageBlockSection pbs = new Component.Apex.PageBlockSection(columns = 2);
        selectedValues = new Map<String, String>();
        
        
        for (string fieldName : FieldList)
        {
            Component.Apex.PageBlockSectionItem pbsi = new Component.Apex.PageBlockSectionItem();
            Schema.DescribeFieldResult field = (FieldMap.get(fieldName)).getDescribe();
    
            if (field.isUpdateable() && field.IsAccessible())
            {
                Schema.DisplayType dt = field.getType();
                Component.Apex.OutputLabel lblText = new Component.Apex.OutputLabel(escape = false);
                lblText.value = field.getLabel();
                pbsi.childComponents.add(lblText);
                
                Component.Apex.SelectList selList = new Component.Apex.SelectList(id = field.getName(), multiselect = false, size = 1, style = 'width:200px;', value=selectedValues.get(field.getName()));
                
                selectedValues.put(field.getName(), '');                
                if (dt == Schema.DisplayType.Integer || dt == Schema.DisplayType.Double || dt == Schema.DisplayType.Currency || dt == Schema.DisplayType.Percent)
                {
                    AddSelectOption(selList, 'Keep highest value');
                    AddSelectOption(selList, 'Keep lowest value');
                    AddSelectOption(selList, 'Keep master value');
                    pbsi.childComponents.add(selList);
                    pbs.childComponents.add(pbsi);
                }
                
                Component.Apex.ActionSupport actSupport = new Component.Apex.ActionSupport(event='onchange', reRender='theTable', status='theStatus');
                selList.childComponents.add(actSupport);
                
            }
        }
    
        return pbs;
    }
    
    private void AddSelectOption(Component.Apex.SelectList selList, string option)
    {
         Component.Apex.SelectOption selOption = new Component.Apex.SelectOption();
         selOption.itemLabel = option;
         selOption.itemValue = option;
         selList.childComponents.add(selOption);
    }

}