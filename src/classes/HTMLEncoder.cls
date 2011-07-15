public class HTMLEncoder {

	public static string ReplaceReservedCharacters( string input ){
		if( input == null )
			return '';

		return input.replace( '&', '&amp;' )
					.replace( '"', '&quot;' )
					.replace( '\'', '&apos;' )
					.replace( '<', '&lt;' )
					.replace( '>', '&gt;' );

	}
}