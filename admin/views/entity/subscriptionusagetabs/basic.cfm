<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />

<cfparam name="rc.subscriptionUsage" type="any">
<cfparam name="rc.edit" type="boolean">

<cfoutput>
	<hb:HibachiPropertyRow>
		<hb:HibachiPropertyList divClass="col-md-6">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="currentStatusType" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="subscriptionOrderItemType" edit="false">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="autoRenewFlag" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="autoPayFlag" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="renewalPrice" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="accountPaymentMethod" edit="#rc.edit#">
		</hb:HibachiPropertyList>
		<hb:HibachiPropertyList divClass="col-md-6">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="expirationDate" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="gracePeriodTerm" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="nextBillDate" edit="#rc.edit#">
			<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage#" property="nextReminderEmailDate" edit="#rc.edit#">
			<cfif !isNull(rc.subscriptionUsage.getRenewalSku()) && !rc.edit>
				<hb:HibachiPropertyDisplay object="#rc.subscriptionUsage.getRenewalSku()#" fieldname="renewalSku.skuCode" property="skuCode" edit="#rc.edit#" title="#$.slatwall.getRBKey('define.renewalSku')#" valuelink="#$.slatwall.buildURL(action='admin:entity.detailsku',querystring='skuID=#rc.subscriptionUsage.getRenewalSku().getSkuID()#')#"/>
			<cfelseif rc.edit>
				<swa:SlatwallErrorDisplay object="#rc.subscriptionUsage#" errorName="renewalSku" />
				<hb:HibachiListingDisplay smartList="#rc.subscriptionUsage.getSubscriptionSkuSmartList()#"
										  selectValue="#rc.subscriptionUsage.getRenewalSku().getSkuID()#"
										  selectFieldName="renewalSku.skuID"
										  title="#$.slatwall.rbKey('define.renewalSku')#"
										  edit="#rc.edit#">
					<hb:HibachiListingColumn propertyIdentifier="skuCode" />
					<hb:HibachiListingColumn propertyIdentifier="skuName" />
					<hb:HibachiListingColumn propertyIdentifier="skuDescription" />
					<hb:HibachiListingColumn propertyIdentifier="subscriptionTerm.subscriptionTermName" />
					<hb:HibachiListingColumn propertyIdentifier="price" />
				</hb:HibachiListingDisplay>
			</cfif>
		</hb:HibachiPropertyList>
	</hb:HibachiPropertyRow>

</cfoutput>

