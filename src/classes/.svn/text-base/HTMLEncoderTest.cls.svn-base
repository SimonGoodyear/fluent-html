@isTest
private class HTMLEncoderTest {

	private static testMethod void nullString(){
		System.assertEquals('', HTMLEncoder.ReplaceReservedCharacters(null));
	}
	
	private static testMethod void replace_amp(){
		System.assertEquals('&amp;', HTMLEncoder.ReplaceReservedCharacters('&'));
	}
	
	private static testMethod void replace_quot(){
		System.assertEquals('&quot;', HTMLEncoder.ReplaceReservedCharacters('"'));
	}
	
	private static testMethod void replace_apos(){
		System.assertEquals('&apos;', HTMLEncoder.ReplaceReservedCharacters('\''));
	}
	
	private static testMethod void replace_lt(){
		System.assertEquals('&lt;', HTMLEncoder.ReplaceReservedCharacters('<'));
	}
	
	private static testMethod void replace_gt(){
		System.assertEquals('&gt;', HTMLEncoder.ReplaceReservedCharacters('>'));
	}

}