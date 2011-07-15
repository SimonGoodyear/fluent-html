public class FluentHTML {

    private DOM.Document doc = new DOM.Document( );
    private DOM.Xmlnode root;
    private Map<integer,string> children = new Map<integer,string>();
    private integer childIdx = 0;
    
    public FluentHTML(){
        root = doc.createRootElement('root', null, null);
    }

    /** Create any HTML element
    */
    public FluentHTML generic( string tag, string text, Map<string,string> attrs){
        DOM.XmlNode node = mapAttributes(root.addChildElement(tag, null, null), attrs);
	    addTextNode(node, text);
        return this;
    }

    /** Anchor tag
    */
    public FluentHTML a( string id, string href, string text ){
        return a(id, href, text, null);
    }
    public FluentHTML a( string id, string href, string text, Map<string,string> attrs ){
        DOM.Xmlnode node = root.addChildElement('a', null, null);
        assignAttribute(node, 'id', id);
        assignAttribute(node, 'href', href);
        mapAttributes(node, attrs);
        addTextNode(node, text);
        return this;
    }

    /** Line break
    */
    public FluentHTML br(){
        root.addChildElement('br', null, null);
        return this;
    }

    /** Ordered list
    */
    public FluentHTML ol( string id, LIFactory items ){
        addChild(assignAttribute(root.addChildElement('ol', null, null), 'id', id), items.render());
        return this;
    }

    /** Unordered list
    */
    public FluentHTML ul( string id, LIFactory items ){
        addChild(assignAttribute(root.addChildElement('ul', null, null), 'id', id), items.render());
        return this;
    }

    /** Image
    */
    public FluentHTML img( string id, string src ){
        return img(id, src, null, null);
    }
    public FluentHTML img( string id, string src, string alt ){
        return img(id, src, alt, null);
    }   
    public FluentHTML img( string id, string src, string alt, Map<string,string> attrs ){
        DOM.Xmlnode node = root.addChildElement('img', null, null);
        assignAttribute(node, 'id', id);
        assignAttribute(node, 'src', src);
        assignAttribute(node, 'alt', alt);
        mapAttributes(node, attrs);
        return this;
    }
    
    /** Input
    */
    public FluentHTML input( string id, string inputType, string value ){
        return input(id, inputType, value, null);
    }
    public FluentHTML input( string id, string inputType, string value, Map<string,string> attrs ){
        DOM.Xmlnode node = root.addChildElement('input', null, null);
        assignAttribute(node, 'id', id);
        assignAttribute(node, 'type', inputType);
        assignAttribute(node, 'value', value);
        mapAttributes(node, attrs);
        return this;
    }   
    
    
    public FluentHTML table( string id, Map<string,string> attrs, TRFactory rows ){
        DOM.Xmlnode node = root.addChildElement('table', null, null);
        assignAttribute(node, 'id', id);
        mapAttributes(node, attrs);
        addChild(node, rows.render());
        
        return this;
    }
    
    
    
    /** Div
    */
    public FluentHTML div( string id, string text ){
        return div(id, text, null, null);      
    }
    public FluentHTML div( string id, string text, FluentHTML innerHTML ){
        return div(id, text, innerHTML, null);     
    }
    public FluentHTML div( string id, string text, FluentHTML innerHTML, Map<string,string> attrs ){
        return container('div', id, text, innerHTML, attrs);    
    }
    
    /** Span
    */
    public FluentHTML span( string id, string text ){
        return span(id, text, null, null);     
    }
    public FluentHTML span( string id, string text, FluentHTML innerHTML ){
        return span(id, text, innerHTML, null);        
    }
    public FluentHTML span( string id, string text, FluentHTML innerHTML, Map<string,string> attrs ){
        return container('span', id, text, innerHTML, attrs);   
    }
    
    /** Paragraph
    */
    public FluentHTML p( string id, string text ){
        return p(id, text, null, null);        
    }
    public FluentHTML p( string id, string text, FluentHTML innerHTML ){
        return p(id, text, innerHTML, null);       
    }
    public FluentHTML p( string id, string text, FluentHTML innerHTML, Map<string,string> attrs ){
        return container('p', id, text, innerHTML, attrs);  
    }
    


    public string render(){
        string html = doc.toXmlString().replace('<?xml version="1.0" encoding="UTF-8"?>','').replace('<root>','').replace('<root />','').replace('</root>', '');
        for(integer i : children.keySet()){
            html = html.replace('<' + i + ' />', children.get(i));
        }
        return html;
    }


    private FluentHTML container( string flavour, string id, string text, FluentHTML innerHTML, Map<string,string> attrs ){
        DOM.Xmlnode node = root.addChildElement(flavour, null, null);
        addTextNode(node, text);
        assignAttribute(node, 'id', id);
        addChild( mapAttributes(node, attrs), innerHTML == null ? '' : innerHTML.render() );
        return this;    
    }


    
    private DOM.Xmlnode addChild( DOM.Xmlnode node, string childRendered ){
        if( childRendered == null || childRendered == '' )
            return node;
            
        children.put(childIdx, childRendered);
        node.addChildElement(string.valueOf(childIdx++), null, null);       
        return node;
    }
    
    private DOM.Xmlnode addTextNode( DOM.Xmlnode node, string text ){
    	if( text == null )
    		return node;
    		
		node.addTextNode(HTMLEncoder.ReplaceReservedCharacters(text));
		return node;
		
    }
    
    private DOM.Xmlnode mapAttributes(DOM.Xmlnode node, Map<string,string> attrs ){
        if( attrs == null )
            return node;
            
        for( string attr : attrs.keySet() ){
            assignAttribute(node, attr, attrs.get(attr));
        }
        
        return node;
    }
    
    private DOM.Xmlnode assignAttribute( DOM.Xmlnode node, string attr, string value ){
        if( value == null )
            return node;
            
        node.setAttribute(attr, value);
        return node;
    }
    
    public class LIFactory{
        private string rendered = '';
        public LIFactory li( string text ){
            rendered += '<li>' + text + '</li>';
            return this;
        }
        public string render(){
            return rendered;
        }
    }
    
    public class TRFactory{
        private string rendered = '';
        
        public TRFactory tr( Map<string,string> attrs, TDFactory tds ){
            String attrTemp = '';
            if( attrs != null ){
                for( string attr : attrs.keySet() ){
                    attrTemp += attr + '="' + attrs.get(attr) + '" ';
                }
				attrTemp = attrTemp.substring(0, attrTemp.length()-1);
        	}
            rendered += '<tr ' + attrTemp + '>' + tds.render() + '</tr>'; 
            return this;
        }
        
        public string render(){
            return rendered;
        }
    }
    
    public class TDFactory{
        private string rendered = '';
    
        public TDFactory td( string text, Map<string,string> attrs, FluentHTML innerHTML){
            String attrTemp = '';
            if( attrs != null ){
                for( string attr : attrs.keySet() ){
                    attrTemp += attr + '="' + attrs.get(attr) + '" ';
                }
                attrTemp = attrTemp.substring(0, attrTemp.length()-1);
            }
            rendered += '<td ' + attrTemp + '>' + (text==null ? '' : text) + (innerHTML== null ? '' : innerHTML.render()) + '</td>';
            return this;
        }

        public string render(){
            return rendered;
        }
    }
    
}