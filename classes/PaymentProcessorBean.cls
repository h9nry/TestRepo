public with sharing class PaymentProcessorBean extends AbstractBean {
	
	String id {get; set;}
	String credential {get; set;}

	public PaymentProcessorBean() {
		this.type = PaymentProcessorBean.class.toString();
	}


}