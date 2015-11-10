public class SampleClass {

	public String name1;
	public String name2;
	public List<Integer> name3;

	
	public static SampleClass parse(String json) {
		return (SampleClass) System.JSON.deserialize(json, SampleClass.class);
	}
	
	/**
	static testMethod void testParse() {
		String json = '{'+
		'\"name1\":\"value\",'+
		'\"name2\":\"value\",'+
		'\"name3\": [1, 2, 3, 4]'+
		'}';
		SampleClass obj = parse(json);
		System.assert(obj != null);
	}
	**/
}