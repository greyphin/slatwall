/// <reference path="../../../../../client/typings/tsd.d.ts" />
/// <reference path="../../../../../client/typings/slatwallTypeScript.d.ts" />
module slatwalladmin {
	'use strict';
	
	export class SWAddOrderItemRecipientController {
		

		public adding:boolean; 
        public orderItemGiftRecipients:Array<slatwalladmin.GiftRecipient>; 
        public quantity:number;
        public searchText:string; 
		public collection;  
        public currentGiftRecipient:slatwalladmin.GiftRecipient;
		public showInvalidAddFormMessage; 
		
		public static $inject=["$slatwall"];
		
		constructor(private $slatwall:ngSlatwall.$Slatwall){
			this.adding = false; 
			this.searchText = ""; 
			var count = 1;
			this.currentGiftRecipient = new slatwalladmin.GiftRecipient();
			this.orderItemGiftRecipients = [];
			this.showInvalidAddFormMessage = false;
		}
		
		addGiftRecipientFromAccountList = (account:any):void =>{
			var giftRecipient = new GiftRecipient();
			giftRecipient.firstName = account.firstName; 
			giftRecipient.lastName = account.lastName; 
			giftRecipient.email = account.primaryEmailAddress_emailAddress;
			giftRecipient.account = true; 
			this.orderItemGiftRecipients.push(giftRecipient); 
			this.searchText = "";   
		}
        
		getUnassignedCountArray = ():number[] =>{
			var unassignedCountArray = new Array();

			for(var i = 1; i <= this.getUnassignedCount(); i++ ){			
					unassignedCountArray.push(i);
			}		

			return unassignedCountArray; 
		}
		
		getAssignedCount = ():number =>{
		
			var assignedCount = 0; 
			
			angular.forEach(this.orderItemGiftRecipients,(orderItemGiftRecipient)=>{
					assignedCount += orderItemGiftRecipient.quantity;
			});
			
			return assignedCount; 

		}

		getUnassignedCount = ():number =>{
			var unassignedCount = this.quantity; 

			angular.forEach(this.orderItemGiftRecipients,(orderItemGiftRecipient)=>{
					unassignedCount -= orderItemGiftRecipient.quantity;
			});

			return unassignedCount;
		}

		addGiftRecipient = ():void =>{
			console.log("is valid" + "   " + this.currentGiftRecipient.valid());
			console.log(this.showInvalidAddFormMessage);
			if(this.currentGiftRecipient.valid()){
				this.adding = false; 
				var giftRecipient = new slatwalladmin.GiftRecipient();
				angular.extend(giftRecipient,this.currentGiftRecipient);
				this.orderItemGiftRecipients.push(giftRecipient);
				this.currentGiftRecipient = new slatwalladmin.GiftRecipient(); 
				this.searchText = ""; 
			} else { 
				this.showInvalidAddFormMessage = true;
				console.log(this.showInvalidAddFormMessage);
			}
		}
		
		cancelAddRecipient = ():void =>{
			this.adding = false; 
			this.currentGiftRecipient = new slatwalladmin.GiftRecipient(); 
			this.searchText = ""; 
		}

		startFormWithName = (searchString = this.searchText):void =>{
			this.adding = true; 
			
			if(searchString != ""){
				this.currentGiftRecipient.firstName = searchString; 
				this.searchText = ""; 
			}
		}

		getTotalQuantity = ():number =>{
			var totalQuantity = 0;
			angular.forEach(this.orderItemGiftRecipients,(orderItemGiftRecipient:slatwalladmin.GiftRecipient)=>{
					totalQuantity += orderItemGiftRecipient.quantity;
			});
			return totalQuantity;
		}

		getMessageCharactersLeft = ():number =>{				
			if(angular.isDefined(this.currentGiftRecipient.giftMessage)){ 
				return 250 - this.currentGiftRecipient.giftMessage.length;
			} else { 
				return 250; 
			}
		}
		
	}
    
    export class SWAddOrderItemGiftRecipient implements ng.IDirective{
        
		public static $inject=["$slatwall"];
		public templateUrl; 
		public restrict = "EA"; 
		public transclude = true; 
		public scope = {}; 	
		
		public bindToController = {
			"quantity":"=", 
			"orderItemGiftRecipients":"=", 
			"adding":"=", 
			"searchText":"=", 
			"currentgiftRecipient":"=",
			"showInvalidAddFormMessage":"=?"
		};
		
		public controller=SWAddOrderItemRecipientController;
        public controllerAs="addGiftRecipientControl";
		
		
		constructor(private $slatwall:ngSlatwall.$Slatwall, private partialsPath){
			this.templateUrl = partialsPath + "entity/OrderItemGiftRecipient/addorderitemgiftrecipient.html";
		}

        public link:ng.IDirectiveLinkFn = ($scope: ng.IScope, element: ng.IAugmentedJQuery, attrs:ng.IAttributes) =>{

		}
    }
    
    angular.module('slatwalladmin').directive('swAddOrderItemGiftRecipient',
		["$slatwall", "partialsPath", 
			($slatwall, partialsPath) => 
				new SWAddOrderItemGiftRecipient($slatwall, partialsPath)]); 

}
