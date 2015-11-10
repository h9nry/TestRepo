public with sharing class RomtingDemoCtr {
	
	public Account a { 
		get{
			if(a == null){
				a = new Account();
			}
			return a;
		}
		set;
	}

	@RemoteAction
    public static List<MyWrapper> retrieveWrappedAccounts() {
        List<MyWrapper> wrappedAccounts = new List<MyWrapper>();
        for(Account a : [select Id, Name, Industry, AnnualRevenue from Account]){
        	wrappedAccounts.add(new MyWrapper(a, false, 
        		 EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(a.Id)))));
        }
        return wrappedAccounts;
    }

    public class MyWrapper {

    	public Account acct { get; set; }
    	public Boolean checked { get; set; }
    	public String anotherInformation { get; set; }

    	public MyWrapper(Account acct, Boolean checked, String anotherInformation){
    		this.acct = acct;
    		this.checked = checked;
    		this.anotherInformation = anotherInformation;
    	}

    }
}