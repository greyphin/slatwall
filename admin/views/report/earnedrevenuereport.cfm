<cfparam name="rc.subscriptionType" default=""/>
<cfparam name="rc.productType" default=""/>
<cfparam name="rc.productID" default=""/>
<cfparam name="rc.minDate" default="#CreateDate(Year(now()),1,1)#"/>
<cfparam name="rc.maxDate" default="#CreateDate(Year(now()),Month(now()),Day(now()))#"/>
<cfparam name="showProducts" default="true"/>
<cfoutput>
    
    <cfset slatAction = 'report.earnedRevenueReport'/>
    <!---<cfset earningSubscriptionsCollectionList = $.slatwall.getService('HibachiService').getSubscriptionUsageCollectionList()/>
    <cfset earningSubscriptionsCollectionList.setReportFlag(1)/>
    <cfset earningSubscriptionsCollectionList.setPeriodInterval('Month')/>
    <cfset earningSubscriptionsCollectionList.setDisplayProperties()--->
    
    <!---collection list for delivered items--->
    <cfset earnedRevenueCollectionList = $.slatwall.getService('HibachiService').getSubscriptionOrderDeliveryItemCollectionList()/>
    <cfset earnedRevenueCollectionList.setDisplayProperties('createdDateTime',{isPeriod=true})/>
    <cfset earnedRevenueCollectionList.addDisplayAggregate('earned','SUM','earnedSUM',false,{isMetric=true})/>
    <cfset earnedRevenueCollectionList.addDisplayAggregate('taxAmount','SUM','taxAmountSUM',false,{isMetric=true})/>
    <cfset earnedRevenueCollectionList.addDisplayAggregate('subscriptionOrderItem.subscriptionUsage.subscriptionUsageID','COUNT','subscriptionUsageCount',true,{isMetric=true})/>
    <cfset earnedRevenueCollectionList.setReportFlag(1)/>
    <cfset earnedRevenueCollectionList.setPeriodInterval('Month')/>
    <cfset earnedRevenueCollectionList.addFilter('subscriptionOrderDeliveryItemType.systemCode','soditDelivered')/>
    <cfset earnedRevenueCollectionList.addFilter('quantity',1,">=",'AND','SUM')/>
    <cfset earnedRevenueCollectionList.addFilter('createdDateTime', CreateDateTime(Year(rc.minDate),Month(rc.minDate),Day(rc.minDate),0,0,0),'>=')/>
    <cfset earnedRevenueCollectionList.addFilter('createdDateTime', CreateDateTime(Year(rc.maxDate),Month(rc.maxDate),Day(rc.maxDate),23,59,59),'<=')/>
    
    
    <!---Collection list for refunded items--->
    <cfset refundedRevenueCollectionList = $.slatwall.getService('HibachiService').getSubscriptionOrderDeliveryItemCollectionList()/>
    <cfset refundedRevenueCollectionList.setDisplayProperties('createdDateTime',{isPeriod=true})/>
    <cfset refundedRevenueCollectionList.addDisplayAggregate('earned','SUM','earnedSUM',false,{isMetric=true})/>
    <cfset refundedRevenueCollectionList.addDisplayAggregate('taxAmount','SUM','taxAmountSUM',false,{isMetric=true})/>
    <cfset refundedRevenueCollectionList.addDisplayAggregate('subscriptionOrderItem.subscriptionUsage.subscriptionUsageID','COUNT','subscriptionUsageCount',true,{isMetric=true})/>
    <cfset refundedRevenueCollectionList.setReportFlag(1)/>
    <cfset refundedRevenueCollectionList.setPeriodInterval('Month')/>
    <cfset refundedRevenueCollectionList.addFilter('quantity',1,">=",'AND','SUM')/>
    <cfset refundedRevenueCollectionList.addFilter('subscriptionOrderDeliveryItemType.systemCode','soditRefunded')/>
    <cfset refundedRevenueCollectionList.addFilter('createdDateTime', CreateDateTime(Year(rc.minDate),Month(rc.minDate),Day(rc.minDate),0,0,0),'>=')/>
    <cfset refundedRevenueCollectionList.addFilter('createdDateTime', CreateDateTime(Year(rc.maxDate),Month(rc.maxDate),Day(rc.maxDate),23,59,59),'<=')/>
    
    <!---used to determine when to end the loop--->
    <cfset currentMonth = Month(rc.maxDate)/>
    
    <!--apply filters-->
    
    
    <cfif structKeyExists(rc,'productType') and len(rc.productType)>
        <cfset earnedRevenueCollectionList.addFilter('subscriptionOrderItem.orderItem.sku.product.productType.productTypeID', rc.productType,'IN')/>
        <cfset refundedRevenueCollectionList.addFilter('subscriptionOrderItem.orderItem.sku.product.productType.productTypeID', rc.productType,'IN')/>
    </cfif>
    
    <cfif structKeyExists(rc,'productID') and len(rc.productID)>
        <cfset earnedRevenueCollectionList.addFilter('subscriptionOrderItem.orderItem.sku.product.productID', rc.productID,'IN')/>
        <cfset refundedRevenueCollectionList.addFilter('subscriptionOrderItem.orderItem.sku.product.productID', rc.productID,'IN')/>
    </cfif>
    
    <cfif structKeyExists(rc,'subscriptionType') and len(rc.subscriptionType)>
        <cfset earnedRevenueCollectionList.addFilter('subscriptionOrderItem.subscriptionOrderItemType.systemCode', rc.subscriptionType,'IN')/>
        <cfset refundedRevenueCollectionList.addFilter('subscriptionOrderItem.subscriptionOrderItemType.systemCode', rc.subscriptionType,'IN')/>
    </cfif>
    
    <cfset earnedDataRecords = earnedRevenueCollectionList.getRecords()/>
    <cfset refundedDataRecords = refundedRevenueCollectionList.getRecords()/>
    <cfset possibleMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']/>
    
    <cfinclude template="./revenuereportcontrols.cfm"/>
    
    <cfset currentMonth = Month(rc.minDate)/>
	<cfset currentYear = Year(rc.minDate)/>
	<cfset diff = DateDiff('m',rc.minDate,rc.maxDate)/>
	<cfset to = currentMonth + diff/>
    
    <cfset subscriptionsEarning = []/>
    <cfset earned = []/>
    <cfset taxAmount = []/>
    <cfset refunded = []/>
    <cfset refundedTaxAmount = []/>
    <cfset possibleYearTotal = []/>
    <cfloop from="1" to="#to-currentMonth+1#" index="i">
        <cfset subscriptionsEarning[i] = 0/>
        <cfset earned[i] = 0/>
        <cfset taxAmount[i] = 0/>
        <cfset refunded[i] = 0/>
        <cfset refundedTaxAmount[i] = 0/>
        <cfset possibleYearTotal[i] = 0/>
    </cfloop>
    
    <cfloop array="#earnedDataRecords#" index="dataRecord">
        <cfset index = DateDiff('m',rc.minDate,dataRecord['createdDateTime'])+1/>
        <cfset subscriptionsEarning[index] = dataRecord['subscriptionUsageCount']/>
        <cfset earned[index] = dataRecord['earnedSUM']/>
        <cfset taxAmount[index] = dataRecord['taxAmountSUM']/>
    </cfloop>
    <!---subtract refunds--->
    <cfloop array="#refundedDataRecords#" index="dataRecord">
        <cfset index = DateDiff('m',rc.minDate,dataRecord['createdDateTime'])+1/>
        <cfset refunded[index] = dataRecord['earnedSUM']/>
        <cfset refundedTaxAmount[index] = dataRecord['taxAmountSUM']/>
    </cfloop>
    
    <table class="table table-bordered s-detail-content-table">
        <thead>
            <tr>
                <th></th>
                <cfloop from="#currentMonth-1#" to="#to-1#" index="w">
                    <cfif w % 12 eq 1 and w neq 1>
                        <cfset currentYear++/>
                    </cfif>
                    <th>
                        #possibleMonths[w%12+1]# - #currentYear#
                    </th>
                </cfloop>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Subscriptions Earning</td>
                <cfloop array="#subscriptionsEarning#" index="subscriptionsEarningRecord">
                    <td>#subscriptionsEarningRecord#</td>
                </cfloop>
            </tr>
            <tr>
                <td>Earned Revenue</td>
                <cfloop array="#earned#" index="earnRecord">
                    <td>#$.slatwall.getService('hibachiUtilityService').formatValue(earnRecord,'currency')#</td>
                </cfloop>
            </tr>
            <tr>
                <td>Tax</td>
                <cfloop array="#taxAmount#" index="taxAmountRecord">
                    <td>#$.slatwall.getService('hibachiUtilityService').formatValue(taxAmountRecord,'currency')#</td>
                </cfloop>
            </tr>
             <tr>
                <td>Refunded Revenue</td>
                <cfloop array="#refunded#" index="refundRecord">
                    <td>#$.slatwall.getService('hibachiUtilityService').formatValue(refundRecord,'currency')#</td>
                </cfloop>
            </tr>
            <tr>
                <td>Refunded Tax</td>
                <cfloop array="#refundedTaxAmount#" index="refundedTaxAmountRecord">
                    <td>#$.slatwall.getService('hibachiUtilityService').formatValue(refundedTaxAmountRecord,'currency')#</td>
                </cfloop>
            </tr>
            <tr>
                <td>Total</td>
                <cfloop from="1" to="#arraylen(taxAmount)#" index="i">
                    <td>#$.slatwall.getService('HibachiUtilityService').formatValue(earned[i]+taxAmount[i]-refunded[i]-refundedTaxAmount[i],'currency')#</td>
                </cfloop>
            </tr>
        </tbody>
    </table>
    <cfif showProducts>
        <cfinclude template="./earnedrevenuereportproducts.cfm"/>
    </cfif>
</cfoutput>