public with sharing class AccountExt {

	private final Account myAccount
;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public AccountExt(ApexPages.StandardController stdController) {
        this.myAccount = (Account)stdController.getRecord();
        String str = 'Hello world!';
        str.center(50);

    }
    

    public String getRecordName() {
        return 'Hello ' + (String)myAccount.get('name') + ' (' + (Id)myAccount.get('Id') + ')';
    }
}