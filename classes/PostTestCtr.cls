public class PostTestCtr {

    public String posted {
        get{
            posted = '';
            for(String key : ApexPages.currentPage().getParameters().keySet()){
                System.debug(key + ': ' + ApexPages.currentPage().getParameters().get(key));
            }
            
            return posted;
        }
        set;
    }

}