trigger MyAccountTrigger on Account (before insert) {
	Account acct = new Account();
	acct.Industry = 'myValue';
	
	
}