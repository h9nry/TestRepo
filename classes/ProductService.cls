public with sharing class ProductService {
	
	@RemoteAction
   	public static MProduct queryByCode(String code) {
   		List<Product2> products = [select Id, Name, Family, ProductCode, Description from Product2 where ProductCode = :code];
   		if(products.isEmpty()) {
   			return null;
   		}

   		return new MProduct(products[0].Id, products[0].Name, products[0].Family, products[0].ProductCode, products[0].Description);
        
    }

    public class MProduct {

    	public Id productId { get; set; }
    	public String name { get; set; }
    	public String grp { get; set; }
    	public String code { get; set; }
    	public String description { get; set; }

    	public MProduct(String productId, String name, String grp, String code, String description){
    		this.productId = productId;
    		this.name = name;
    		this.grp = grp;
    		this.code = code;
    		this.description = description;
    	}

    }

}