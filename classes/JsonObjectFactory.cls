/**
 * Class provides static methods for serializing and deserializing of JSON objects.
 *
 * @author 	henry.hess@accenture.com
 * @version	20150201	initial version
 */
public class JsonObjectFactory {
	
	/**
	 * Deserializes a JSON string that conplies with the JSON object structure.
	 * 
	 * @param	String 	the JSON string that has to comply with JSON object structure
	 *
	 * @return	Object 	the resulting object, deserialized with the correct type
	 */
	public static Object deserialize(String jsonStr){
		
		if(jsonStr == null || jsonStr == ''){
			throw new InvalidJsonObjectException('JSON string is null or empty.');
		}
		
		Map<String,Object> result = (Map<String, Object>)JSON.deserializeUntyped(jsonStr);
		System.debug('######' + JSON.deserializeStrict(JSON.serialize(result.get('obj')), Type.forName(String.valueOf(result.get('cls')))));
		
		Object obj;
		if(result.containsKey('cls') && result.containsKey('obj')){
			try{
				obj = JSON.deserializeStrict(JSON.serialize(result.get('obj')), Type.forName(String.valueOf(result.get('cls'))));
			} catch(Exception e){
				throw new InvalidJsonObjectException('Deserializing JSON object failed.', e);
			}
		} else {
			throw new InvalidJsonObjectException('Deserializing failed: invalid JSON object.');
		}
		return obj;
	}

	/**
	 * 
	 */
	public static String serialize(Object obj, Type t, String id){
		
		JsonObjectModel jom = new JsonObjectModel(t.getName(), obj, id);
		String jsonObject = JSON.serialize(jom);
		System.debug('###########: ' + jsonObject);

		// perform cross check
		try{
			Object ccObj = JsonObjectFactory.deserialize(jsonObject);
			System.debug('ccObj:' + String.valueOf(ccObj));
			System.debug('obj' + String.valueOf(obj));
			if(String.valueOf(obj) != String.valueOf(ccObj)){
				throw new InvalidJsonObjectException('Creation of JSON object failed.');
			}
		} catch(Exception e){
			System.debug('######' + e);
			throw new InvalidJsonObjectException('JSON object serialising failed', e);
		}

		return jsonObject;
	}

	/**
	 * Model class for convenient serialization
	 */
	private class JsonObjectModel {
		String cls { get; set; }
		Object obj { get; set; }
		String id { get; set; }

		JsonObjectModel(String cls, Object obj, String id){
			this.cls = cls;
			this.obj = obj;
			this.id = id;
		}
	}

	/**
	 * Custom exception class
	 */
	public class InvalidJsonObjectException extends Exception { }

}