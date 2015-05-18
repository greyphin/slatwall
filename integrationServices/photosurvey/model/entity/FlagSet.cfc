/*    

Slatwall - An Open Source eCommerce Platform    
Copyright (C) ten24, LLC    
    
This program is free software: you can redistribute it and/or modify    
it under the terms of the GNU General Public License as published by    
the Free Software Foundation, either version 3 of the License, or    
(at your option) any later version.    
    
This program is distributed in the hope that it will be useful,    
but WITHOUT ANY WARRANTY; without even the implied warranty of    
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    
GNU General Public License for more details.    
    
You should have received a copy of the GNU General Public License    
along with this program.  If not, see <http://www.gnu.org/licenses/>.    
    
Linking this program statically or dynamically with other modules is    
making a combined work based on this program.  Thus, the terms and    
conditions of the GNU General Public License cover the whole    
combination.    
    
As a special exception, the copyright holders of this program give you    
permission to combine this program with independent modules and your     
custom code, regardless of the license terms of these independent    
modules, and to copy and distribute the resulting program under terms     
of your choice, provided that you follow these specific guidelines:     

- You also meet the terms and conditions of the license of each     
  independent module     
- You must not alter the default display of the Slatwall name or logo from      
  any part of the application     
- Your custom code must not alter or create any files inside Slatwall,     
  except in the following directories:    
	/integrationServices/    

You may copy and distribute the modified version of this program that meets     
the above guidelines as a combined work under the terms of GPL for this program,     
provided that you include the source code of that other code when and as the     
GNU GPL requires distribution of source code.    
    
If you modify this program, you may extend this exception to your version     
of the program, but you are not obligated to do so.    

Notes:    

*/    
component  extends="Slatwall.model.entity.HibachiEntity" entityname="SlatwallFlagSet" table="PhotoSurveyFlagSet" persistent="true" accessors="true" cacheuse="transactional" 
{
	// Persistent Properties    
	property name="flagSetID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="flagSetName" ormtype="string" hint="The flag sets name";
	property name="flagSetDescription" ormtype="string" hint="The flag sets description";
	
	// Calculated Properties    
	
	// Related Object Properties (many-to-one)    
	
	// Related Object Properties (one-to-many)
	property name="surveys" singularname="survey" cfc="Survey" type="array" fieldtype="one-to-many" fkcolumn="surveyID" inverse="true";
	
	// Related Object Properties (many-to-many - owner)    
	/*
	property name="flagTypes" singularname="flagType" cfc="FlagType" fieldtype="many-to-many" linktable="FlagSetTypeGroup" fkcolumn="flagSetID" inversejoincolumn="flagTypeID";
	*/
	// Related Object Properties (many-to-many - inverse)    
	 
	// Remote Properties    
	
	// Audit Properties
	property name="createdDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="createdByAccountID" hb_populateEnabled="false" ormtype="string";
	property name="modifiedDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="modifiedByAccountID" hb_populateEnabled="false" ormtype="string";  
	
	// Non-Persistent Properties    
	
	// ==================== START: Logical Methods =========================     
	
	// ================ START: Non-Persistent Property Methods =================    
	
	// ================  END:  Non-Persistent Property Methods =================     
		    
	// ================= START: Bidirectional Helper Methods ===================    
	
	// ==================  END:  Bidirectional Helper Methods ===================    
	
	// ================= START: Custom Validation Methods ====================    
	    
	// =================  END: Custom Validation Methods =====================    
	    
	// ================= START: Custom Formatting Methods ====================    
	    
	// =================  END: Custom Formatting Methods =====================    
	    
	// =================== START: Overridden Implicit Getters ===================    
	    
	// ===================  END: Overridden Implicit Getters ====================    
	    
	// ================== START: Overridden Smart List Getters ==================    
	    
	// ==================  END: Overridden Smart List Getters ===================    
	
	// ================== START: Overridden Methods ========================    
	    
	// ===================  END:  Overridden Methods ========================    
	    
	// =================== START: ORM Event Hooks  =========================    
	  
	// ===================  END:  ORM Event Hooks  =========================     
	
	
	
	
	
}