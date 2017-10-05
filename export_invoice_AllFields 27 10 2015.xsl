<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version = "1.0"
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="Windows-1252"/>  
	
	<xsl:variable name="CustomerType" select="Corporate"/>
	
	<xsl:template match="root">
	<xsl:text>Type,Department,TaxCode,OriginalNominalCode,OrderID,CompanyName,DebitorNumber,SalesTaxNumber,OrderDate,SellingPriceWithTaxTotal,SellingPriceTotal,TaxValue,BuyingPrice,SellingPriceWithTaxAndAdvancedInvoice,OrderNo,Note1,NominalCode,PaymentDueDate,Street,StreetNumber,PostCode,City,</xsl:text>
	<xsl:text>Quantity,Description,ItemType,ProductCode,SellingPrice,Price,SaleTaxValue,SellingPriceWithTax,SaleTaxIsActiv,OrderTakenBy,GlobalDeptNumber,DeptNumber,CustomerID,SellingCurrencyShow,SellingCurrencyFactor,InsertAs,CustOrderNoRef</xsl:text>
	<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="AdvancedInvoice">
		<xsl:text>
</xsl:text>
		<xsl:text>SA,0,</xsl:text>
		<xsl:choose>
			<xsl:when test="InvoiceSaleTaxValue='0'"><!-- MwSt betrag ist 0 £ -->
				<xsl:text>T0</xsl:text>
			</xsl:when>
			<xsl:otherwise><!-- MwSt betrag ist nicht 0 £-->
				<xsl:text>T4</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>,1200,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceNumber)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(CustomerName)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(CustomerDebitorNumber)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(CustomerSalesTax)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(IndentDate)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSellingPriceWithTax)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSellingPriceWithoutTax)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSaleTaxValue)"/>
		<xsl:text>,,"</xsl:text>
		<xsl:text>","Job Number: </xsl:text>
		<xsl:value-of select="normalize-space(IndentNumber)"/>
		<xsl:text>",4</xsl:text>
		<xsl:value-of select="normalize-space(IndentNumber)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="substring(PaymentDueDate,9,2)"/><xsl:text></xsl:text>
		<xsl:value-of select="substring(PaymentDueDate,6,2)"/><xsl:text></xsl:text>
		<xsl:value-of select="substring(PaymentDueDate,3,2)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceAddress/Address/Street)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceAddress/Address/StreetNumber)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceAddress/Address/PostCode)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceAddress/Address/City)"/>
		<xsl:text>",,,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSellingPriceWithoutTax)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSaleTaxValue)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(InvoiceSellingPriceWithTax)"/>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="ReplaceUserName">
			<xsl:with-param name="UserName" select="AdminstrativeUserName" />
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SupplierNumber)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SellingCurrencyShow)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SellingCurrencyFactor)"/>
		<xsl:text>,</xsl:text>
	</xsl:template>
	
	<xsl:template match="Invoice">
		<xsl:apply-templates select="InvoicePositions"/>
	</xsl:template>
	
	<xsl:template match="InvoicePositions">
		<xsl:apply-templates select="InvoicePosition"/>
	</xsl:template>
  
	<xsl:template match="InvoicePosition">
	<xsl:text>
</xsl:text>
		<xsl:choose>
			<xsl:when test="0 > number(SellingPrice)">
				<xsl:text>SC</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>SI</xsl:text>
			</xsl:otherwise>
		</xsl:choose>		
		<xsl:text>,0,</xsl:text>
		<xsl:choose>
			<xsl:when test="SaleTaxValue='0'"><!-- MwSt betrag ist 0€ -->
				<xsl:choose>
					<xsl:when test="SaleTaxIsActiv='false'">
						<xsl:text>0</xsl:text><!-- MwSt wurde nicht berechnet T0-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>4</xsl:text><!-- MwSt Satz ist 0% T4-->
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><!-- MwSt betrag ist nicht 0€  T1-->
				<xsl:text>1</xsl:text>
			</xsl:otherwise>
		</xsl:choose>		
		<xsl:text>,</xsl:text>
		<xsl:value-of select="ArticleGroupList/ExportResultArticleGroupItem[string-length(Show)=4]/Show"/>
		<xsl:if test="count(ArticleGroupList/ExportResultArticleGroupItem[string-length(Show)=4])=0">
			<xsl:text>4010</xsl:text>
		</xsl:if>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceNumber)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(../../CustomerName)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(../../DebitorNumber)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(../../DispatchSalesTax)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(../../DateInsertString)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../SellingPriceWithTax)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../SellingPrice)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../TaxValueXML)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../BuyingPriceXML)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../SellingPriceWithTaxAndAdvancedInvoice)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(../../IndentNumberXML)"/>
		<xsl:text>","Job Number: </xsl:text>
		<xsl:value-of select="normalize-space(../../IndentNumberXML)"/>
		<xsl:text>"</xsl:text>
		<xsl:text>,"4</xsl:text>
		<xsl:value-of select="normalize-space(../../IndentNumberXML)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="substring(../../PaymentDueDate,9,2)"/><xsl:text>.</xsl:text>
		<xsl:value-of select="substring(../../PaymentDueDate,6,2)"/><xsl:text>.</xsl:text>
		<xsl:value-of select="substring(../../PaymentDueDate,3,2)"/>
		<xsl:text>,"</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Street)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../PostAddressLine1)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/PostCode)"/>
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/City)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(Quantity)"/>
		<xsl:text>,"</xsl:text>
		<xsl:choose><!-- if YOUR_STRING is greater than the MAXIMUM_LENGTH -->
			<xsl:when test="string-length( ArticleText1 ) &gt; 56 "><!-- print out the truncated value followed by "..." -->
				<xsl:value-of select="translate(normalize-space(substring( ArticleText1 ,0, 56 )),'&quot;',' ')"/>...</xsl:when>
			<xsl:otherwise><!-- otherwise print out the whole, un-truncated string -->
				<xsl:value-of select="translate(normalize-space(ArticleText1),'&quot;',' ')"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>",2,"S3",</xsl:text>
		<xsl:choose>
			<xsl:when test="0 > number(SellingPrice)">
				<xsl:value-of select="Quantity * -1 * format-number(SellingPrice div Quantity * normalize-space(SellingCurrencyFactor), '#####0.00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="Quantity * format-number(SellingPrice div Quantity * normalize-space(SellingCurrencyFactor), '#####0.00')"/>
			</xsl:otherwise>
		</xsl:choose>	
		<xsl:text>,</xsl:text>
			<xsl:value-of select="format-number(SellingPrice div Quantity * normalize-space(SellingCurrencyFactor), '#####0.00')"/>	
		<xsl:text>,</xsl:text>
		<xsl:choose>
			<xsl:when test="0 > number(SaleTaxValue)">
				<xsl:value-of select="normalize-space(SaleTaxValue) * -1 * normalize-space(SellingCurrencyFactor)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(SaleTaxValue) * normalize-space(SellingCurrencyFactor)"/>
			</xsl:otherwise>
		</xsl:choose>	
		<xsl:text>,</xsl:text>
		<xsl:choose>
			<xsl:when test="0 > number(SellingPriceWithTax)">
				<xsl:value-of select="format-number(normalize-space(SellingPriceWithTax) * -1 * normalize-space(SellingCurrencyFactor), '#####0.00')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number(normalize-space(SellingPriceWithTax) * normalize-space(SellingCurrencyFactor), '#####0.00')"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SaleTaxIsActiv)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(../../AdminstrativeUserName)"/>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="ReplaceUserName">
			<xsl:with-param name="UserName" select="../../AdminstrativeUserName" />
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:call-template name="ReplaceUserName">
			<xsl:with-param name="UserName" select="../../AdminstrativeUserName" />
		</xsl:call-template>
		<xsl:text>,</xsl:text>
		<xsl:choose>
			<xsl:when test="(../../SupplierNumber)=''">
				<xsl:value-of select="normalize-space(../../DebitorNumber)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(../../SupplierNumber)"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SellingCurrencyShow)"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(SellingCurrencyFactor)"/>
		<xsl:text></xsl:text>
		<xsl:text>,Invoice,</xsl:text>
		<xsl:value-of select="normalize-space(../../CustomerText)"/>		
	</xsl:template>
	
	<xsl:template name="ReplaceUserName">
		<xsl:param name="UserName" />
		
		<xsl:variable name="newUserName" select="normalize-space($UserName)"/>
		
		<xsl:choose>
			<!-- Anfang ersetzen -->
			<xsl:when test="$newUserName='Kein Vertreter'"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Karen McBride'"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Mike Smith'"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Karin Anderson'"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Maxine Herron'"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Mary Jeffrey'"><xsl:text>2</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Julie Clark'"><xsl:text>2</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Jo Carey'"><xsl:text>2</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Joanne Carey'"><xsl:text>2</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Rod Mountford'"><xsl:text>9</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Theresa Richardson'"><xsl:text>10</xsl:text></xsl:when>
			<xsl:when test="$newUserName='Pamela Docherty'"><xsl:text>10</xsl:text></xsl:when>
			<!-- Ende ersetzen -->
			
			<xsl:otherwise>
				<xsl:text>0</xsl:text>	
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="ReplaceCurrency">
		<xsl:param name="Currency" />
		
		<xsl:variable name="newCurrency" select="normalize-space($Currency)"/>
		
		<xsl:choose>
			<!-- Anfang ersetzen -->
			<xsl:when test="$newCurrency='GBP'"><xsl:text>£</xsl:text></xsl:when>
			<xsl:when test="$newCurrency='EUR'"><xsl:text>€</xsl:text></xsl:when>
			<xsl:when test="$newCurrency='USD'"><xsl:text>$</xsl:text></xsl:when>
			<!-- Ende ersetzen -->
			
			<xsl:otherwise>
				<xsl:text>Â£</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
</xsl:stylesheet>