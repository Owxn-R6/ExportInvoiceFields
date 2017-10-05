<?xml version="1.0" encoding="Windows-1252" ?>
<xsl:stylesheet version = "1.0"
	xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="Windows-1252"/>  
	
	<xsl:variable name="CustomerType" select="Corporate"/>
	
	<xsl:template match="root">
	<xsl:text>ContactName,EmailAddress,POAddressLine1,POAddressLine2,POAddressLine3,POAddressLine4,POCity,PORegion,POPostalCode,POCountry,InvoiceNumber,Reference,InvoiceDate,DueDate,Total,InventoryItemCode,Description,Quantity,UnitAmount,Discount, AccountCode,TaxType,TaxAmount,TrackingName1,TrackingOption1,TrackingName2,TrackingOption2,Currency,Branding Theme</xsl:text>
	<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="AdvancedInvoice">
	</xsl:template>
	
	<xsl:template match="CreditNote">
		<xsl:apply-templates select="CreditNotePositionsPositions"/>
	</xsl:template>
	
	<xsl:template match="CreditNotePositionsPositions">
	<xsl:choose>
		<xsl:when test="count(CreditNotePositionsPosition)!=0">
			<xsl:apply-templates select="CreditNotePositionsPosition"/><!-- Credit Note With Positions-->
		</xsl:when>
		<xsl:otherwise> <!-- Credit Note No Positions-->
			<xsl:text>
</xsl:text>
			<xsl:text>"</xsl:text>
			<xsl:value-of select="normalize-space(../CustomerName)"/><!-- ContactName -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/Mail)"/><!-- EmailAddress -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/Line1)"/><!-- POAddressLine1 -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/Line2)"/><!-- POAddressLine2 -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/Line3)"/><!-- POAddressLine3 -->
			<xsl:text>","</xsl:text>
			<!-- POAddressLine4 blank -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/City)"/><!-- POCity -->
			<xsl:text>","</xsl:text>		
			<!-- PORegion blank-->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/PostCode)"/><!-- POPostalCode -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceAddress/Address/CountryIsoCode)"/><!-- POCountry -->
			<xsl:text>",</xsl:text>
			<xsl:value-of select="normalize-space(../CreditNoteNumber)"/><!-- CreditNoteNumber -->
			<xsl:text>,"Related Invoice: </xsl:text>
			<xsl:value-of select="normalize-space(../InvoiceNumbers)"/><!-- Reference (Related InvoiceNumbers) blank if no related invoices-->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="substring(../DateInsert,9,2)"/><xsl:text>/</xsl:text><!-- InvoiceDate -->
			<xsl:value-of select="substring(../DateInsert,6,2)"/><xsl:text>/</xsl:text>
			<xsl:value-of select="substring(../DateInsert,1,4)"/>
			<xsl:text>",</xsl:text>
			<xsl:value-of select="substring(../DateInsert,9,2)"/><xsl:text>/</xsl:text><!-- DueDate -->
			<xsl:value-of select="substring(../DateInsert,6,2)"/><xsl:text>/</xsl:text>
			<xsl:value-of select="substring(../DateInsert,1,4)"/>
			<xsl:text>,,,"</xsl:text><!-- Total blank, InventoryItemCode blank-->
			<xsl:text>-</xsl:text><!-- Description -->
			<xsl:text>",</xsl:text>
			<xsl:text>1</xsl:text><!-- Quantity -->
			<xsl:text>,</xsl:text>
			<xsl:value-of select="normalize-space( ../SellingPriceWithoutTax * -1)"/><!-- Value of Credit Note -->
			<xsl:text>,,</xsl:text><!-- Discount blank-->
			<xsl:text>4000</xsl:text><!-- AccountCode -->
			<xsl:text>,"</xsl:text>
			<xsl:choose>
			<xsl:when test="number(../SaleTaxValue)=0"><!-- VAT value is £0 -->
				<xsl:choose>
					<xsl:when test="../SaleTaxIsActiv='false'">
						<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT does not apply -->
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="number(../SellingPrice)=0">
								<xsl:text>20% (VAT on Income)</xsl:text><!-- VAT does apply but salesprice = £0 so VAT = £0-->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT was applied but VAT percentage = 0%-->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><!-- VAT was applied -->
				<xsl:text>20% (VAT on Income)</xsl:text>
			</xsl:otherwise>
			</xsl:choose>	<!-- TaxType -->
			<xsl:text>",</xsl:text><!-- TaxAmount blank -->
			<xsl:text>,</xsl:text><!-- TrackingName1 blank -->
			<xsl:text>,</xsl:text><!-- TrackingOption1 blank -->
			<xsl:text>,</xsl:text><!-- TrackingName2 blank --><!-- TrackingOption2 blank -->	
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	
	<xsl:template match="CreditNotePositionsPosition">
		<xsl:text>
</xsl:text>
		<xsl:text>"</xsl:text>
		<xsl:value-of select="normalize-space(../../CustomerName)"/><!-- ContactName -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Mail)"/><!-- EmailAddress -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line1)"/><!-- POAddressLine1 -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line2)"/><!-- POAddressLine2 -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line3)"/><!-- POAddressLine3 -->
		<xsl:text>","</xsl:text>
		<!-- POAddressLine4 blank -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/City)"/><!-- POCity -->
		<xsl:text>","</xsl:text>		
		<!-- PORegion blank-->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/PostCode)"/><!-- POPostalCode -->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/CountryIsoCode)"/><!-- POCountry -->
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(../../CreditNoteNumber)"/><!-- CreditNoteNumber -->
		<xsl:text>,"Related Invoice: </xsl:text>
		<xsl:value-of select="normalize-space(../../InvoiceNumbers)"/><!-- Reference (Related InvoiceNumbers) blank if no related invoices-->
		<xsl:text>","</xsl:text>
		<xsl:value-of select="substring(../../DateInsert,9,2)"/><xsl:text>/</xsl:text><!-- InvoiceDate -->
		<xsl:value-of select="substring(../../DateInsert,6,2)"/><xsl:text>/</xsl:text>
		<xsl:value-of select="substring(../../DateInsert,1,4)"/>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="substring(../../DateInsert,9,2)"/><xsl:text>/</xsl:text><!-- DueDate -->
		<xsl:value-of select="substring(../../DateInsert,6,2)"/><xsl:text>/</xsl:text>
		<xsl:value-of select="substring(../../DateInsert,1,4)"/>
		<xsl:text>,,,"</xsl:text><!-- Total blank, InventoryItemCode blank-->
		<xsl:choose><!-- if Description is greater than 30 --> <!-- Description -->
			<xsl:when test="string-length( ArticleText1 ) &gt; 26 "><!-- print out the truncated value followed by "..." -->
				<xsl:value-of select="normalize-space(substring( ArticleText1 ,0, 26 ))"/>...</xsl:when>
			<xsl:otherwise><!-- otherwise print out the whole, un-truncated string -->
				<xsl:value-of select="normalize-space(ArticleText1)"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>",</xsl:text>
		<xsl:value-of select="normalize-space(round(Quantity))"/><!-- Quantity -->
		<xsl:text>,</xsl:text>
		<xsl:value-of select="normalize-space(  (SellingPrice div Quantity) * -1)"/><!-- UnitAmount -->
		<xsl:text>,,</xsl:text><!-- Discount blank-->
		<xsl:value-of select="ArticleGroupList/ExportResultArticleGroupItem[string-length(Show)=3]/Show"/>
		<xsl:if test="count(ArticleGroupList/ExportResultArticleGroupItem[string-length(Show)=3])=0">
			<xsl:text>4000</xsl:text><!-- AccountCode based on product group can be overridden by the use of a 3 character product group-->
		</xsl:if>
		<xsl:text>,"</xsl:text>
		<xsl:choose>
		<xsl:when test="number(SaleTaxValue)=0"><!-- VAT value is £0 -->
			<xsl:choose>
				<xsl:when test="SaleTaxIsActiv='false'">
					<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT does not apply -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="number(SellingPrice)=0">
							<xsl:text>20% (VAT on Income)</xsl:text><!-- VAT does apply but salesprice = £0 so VAT = £0-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT was applied but VAT percentage = 0%-->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise><!-- VAT was applied -->
			<xsl:text>20% (VAT on Income)</xsl:text>
		</xsl:otherwise>
		</xsl:choose>	<!-- TaxType -->
		<xsl:text>",</xsl:text><!-- TaxAmount blank -->
		<xsl:text>,</xsl:text><!-- TrackingName1 blank -->
		<xsl:text>,</xsl:text><!-- TrackingOption1 blank -->
		<xsl:text>,</xsl:text><!-- TrackingName2 blank --><!-- TrackingOption2 blank -->	
	</xsl:template>

	
	<xsl:template match="Invoice">
		<xsl:apply-templates select="InvoicePositions"/>
	</xsl:template>
	
	<xsl:template match="InvoicePositions">
		<xsl:apply-templates select="InvoicePosition"/>
	</xsl:template>
	
	<xsl:template match="InvoicePosition">
	<xsl:choose>
		<xsl:when test="number(SellingPrice)!=0">
<xsl:text>
</xsl:text>
			<xsl:text>"</xsl:text>
			<xsl:value-of select="normalize-space(../../CustomerName)"/><!-- ContactName -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Mail)"/><!-- EmailAddress -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line1)"/><!-- POAddressLine1 -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line2)"/><!-- POAddressLine2 -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/Line3)"/><!-- POAddressLine3 -->
			<xsl:text>","</xsl:text>
			<!-- POAddressLine4 blank -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/City)"/><!-- POCity -->
			<xsl:text>","</xsl:text>		
			<!-- PORegion blank-->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/PostCode)"/><!-- POPostalCode -->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceAddress/Address/CountryIsoCode)"/><!-- POCountry -->
			<xsl:text>",</xsl:text>
			<xsl:value-of select="normalize-space(../../InvoiceNumber)"/><!-- InvoiceNumber -->
			<xsl:text>,"</xsl:text>
			<xsl:value-of select="normalize-space(../../IndentNumberXML)"/><!-- Sales Order Number		-->
			<xsl:text>","</xsl:text>
			<xsl:value-of select="normalize-space(../../DateInsertString)"/><!-- InvoiceDate -->
			<xsl:text>",</xsl:text>
			<xsl:value-of select="substring(../../PaymentDueDate,9,2)"/><xsl:text>/</xsl:text><!-- DueDate -->
			<xsl:value-of select="substring(../../PaymentDueDate,6,2)"/><xsl:text>/</xsl:text>
			<xsl:value-of select="substring(../../PaymentDueDate,1,4)"/>
			<xsl:text>,,,"</xsl:text><!-- Total blank, InventoryItemCode blank-->
			<xsl:choose><!-- if Description is greater than 30 --> <!-- Description -->
				<xsl:when test="string-length( ArticleText1 ) &gt; 26 "><!-- print out the truncated value followed by "..." -->
					<xsl:value-of select="normalize-space(substring( ArticleText1 ,0, 26 ))"/>...</xsl:when>
				<xsl:otherwise><!-- otherwise print out the whole, un-truncated string -->
					<xsl:value-of select="normalize-space(ArticleText1)"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>",</xsl:text>
			<xsl:value-of select="normalize-space(round(Quantity))"/><!-- Quantity -->
			<xsl:text>,</xsl:text>
			<xsl:value-of select="normalize-space(SellingPrice div Quantity)"/><!-- UnitAmount -->
			<xsl:text>,,</xsl:text><!-- Discount blank-->
			<xsl:call-template name="GetNominalCode">
				<xsl:with-param name="CustomerText" select="normalize-space(../../CustomerNoticeIntern)" />
			</xsl:call-template>
			<xsl:text>,"</xsl:text>
			<xsl:choose>
			<xsl:when test="number(SaleTaxValue)=0"><!-- VAT value is £0 -->
				<xsl:choose>
					<xsl:when test="SaleTaxIsActiv='false'">
						<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT does not apply -->
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="number(SellingPrice)=0">
								<xsl:text>20% (VAT on Income)</xsl:text><!-- VAT does apply but salesprice = £0 so VAT = £0-->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Zero Rated EC Goods Income</xsl:text><!-- VAT was applied but VAT percentage = 0%-->
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><!-- VAT was applied -->
				<xsl:text>20% (VAT on Income)</xsl:text>
			</xsl:otherwise>
			</xsl:choose>	<!-- TaxType -->
			<xsl:text>",</xsl:text><!-- TaxAmount blank -->
			<xsl:text>,</xsl:text><!-- TrackingName1 blank -->
			<xsl:text>,</xsl:text><!-- TrackingOption1 blank -->
			<xsl:text>,</xsl:text><!-- TrackingName2 blank --><!-- TrackingOption2 blank -->
		</xsl:when>
	</xsl:choose>
	</xsl:template>
		<xsl:template name="GetNominalCode">
		<xsl:param name="CustomerText" />
		<!-- <xsl:variable name="myCustomerText" select="normalize-space($CustomerText)"/> -->
		<xsl:variable name="myCustomerText" select="translate(normalize-space($CustomerText),'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		<xsl:choose>
			<xsl:when test="contains($myCustomerText, 'NON')">
			<xsl:text>300200</xsl:text></xsl:when>
			<xsl:otherwise><xsl:text>300300</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>