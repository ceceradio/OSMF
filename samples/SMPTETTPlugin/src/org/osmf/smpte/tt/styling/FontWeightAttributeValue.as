/***********************************************************
 * 
 * Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
 *
 * *********************************************************
 * The contents of this file are subject to the Berkeley Software Distribution (BSD) Licence
 * (the "License"); you may not use this file except in
 * compliance with the License. 
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 *
 * The Initial Developer of the Original Code is Adobe Systems Incorporated.
 * Portions created by Adobe Systems Incorporated are Copyright (C) 2011 Adobe Systems
 * Incorporated. All Rights Reserved.
 **********************************************************/
package org.osmf.smpte.tt.styling
{
	import org.osmf.smpte.tt.enums.Enum;
	
	public class FontWeightAttributeValue extends Enum
	{
		{initEnum(FontWeightAttributeValue);} // static ctor
		
		public static const REGULAR:FontWeightAttributeValue	= new FontWeightAttributeValue("normal");
		public static const BOLD:FontWeightAttributeValue = new FontWeightAttributeValue("bold");
		
		// Constant query.
		public static function getConstants():Array
		{ 
			return Enum.getConstants(FontWeightAttributeValue);
		}
		public static function parseConstant(i_constantName:String, i_caseSensitive:Boolean=false):FontWeightAttributeValue
		{ 
			return FontWeightAttributeValue(Enum.parseConstant(FontWeightAttributeValue, i_constantName, i_caseSensitive));
		}
		
		// constant attribute
		public function get value():String { return _value; }   
		
		// Private.
		/* private */ function FontWeightAttributeValue(value:String)
		{ 
			_value = value;
		}
		private var _value:String;
	}
}