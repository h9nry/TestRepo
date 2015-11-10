public class BeanFactory {
	
	public static Object createObject(String jsonStr){
		String cls = null;
		String id = null;
		Object obj = null;

		JSONParser p = JSON.createParser(jsonStr);
		System.debug('####### starting parser');
		
		// first get the type
		while(p.nextToken() != null){
			System.debug('####### name:' + p.getCurrentName());
			
			if(p.getCurrentName() == 'cls'){
				p.nextValue();
				System.debug('####### class value: ' + p.getText());
				cls = p.getText();
				break;
			}
		}

		// then deserialize the bean
		if(cls != null){
			while(p.nextToken() != null){
				System.debug('####### name:' + p.getCurrentName());
			
				// then the actual obj
				if(p.getCurrentName() == 'obj'){
					p.nextToken();
					System.debug('####### obj value:' + p.getText());
					
					try {
						obj = p.readValueAs(Type.forName(cls));
					} catch(Exception e){
						throw new InvalidJsonBeanException('JSON could not be parsed as type ' + cls);
					}
					System.debug(obj);
					break;
				}
			}
		} else {
			throw new InvalidJsonBeanException('JsonBean class property could not be found.');
		}
		return obj;
	}

	public class InvalidJsonBeanException extends Exception { }

}