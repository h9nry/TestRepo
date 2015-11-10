trigger LimitAttachmentSize on Attachment (before insert) {
	
	list<Attachment> att = new List<Attachment>();
    for (Attachment a : Trigger.new) { 
        att.add(a);    
    }
    integer sizecheck = att.get(0).body.size();
    if (sizecheck  > 10){
    	att.get(0).addError('max size 10 byte');
    }
	
}