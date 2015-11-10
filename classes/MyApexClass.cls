public class MyApexClass 
{
    String property1 { get; set; }
    Integer property2 { get; set; }
    List<String> listProperty1 { get; set; }

    public MyApexClass(String p1, Integer p2, List<String> lp){
        this.property1 = p1;
        this.property2 = p2;
        this.listProperty1 = lp;
    }
}