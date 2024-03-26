<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    version="2.0" exclude-result-prefixes="#all">

<xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" indent="yes" omit-xml-declaration="yes"/>

<xsl:import href="./partials/shared.xsl"/>
<xsl:import href="./partials/aot-options.xsl"/>

<xsl:variable name="prev">
		<xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '')"/>
</xsl:variable>
<xsl:variable name="next">
		<xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '')"/>
</xsl:variable>
<xsl:variable name="teiSource">
		<xsl:value-of select="data(tei:TEI/@xml:id)"/>
</xsl:variable>
<xsl:variable name="link">
		<xsl:value-of select="replace($teiSource, '.xml', '')"/>
</xsl:variable>
<xsl:variable name="doc_title">
		<xsl:value-of select=".//tei:titleStmt/tei:title[@type='num']/text()|.//tei:titleStmt/tei:title[@level='a']/text()"/>
</xsl:variable>

<xsl:template match="/">
<div class="flex flex-col">
	<div class="flex flex-row my-4 transcript active p-6">
		<div class="basis-6/12 text px-4 .yes-index">
			<div class="section">
				<div id="column-view" class="reading column">
					<xsl:for-each-group select=".//tei:front/tei:titlePage/*|.//tei:body/tei:div[@type='article']/*" group-starting-with="self::tei:pb">
						<xsl:for-each select="current-group()/self::tei:pb">
							<!-- <xsl:value-of select="*/name()"/> -->
							<xsl:apply-templates select="self::tei:pb"/>
							<xsl:for-each select="current-group()">
								<xsl:apply-templates select="self::tei:docTitle|self::tei:milestone|self::tei:imprimatur|self::tei:ab[@type='imprint']|self::tei:ab[@type='count-date']"/>
							</xsl:for-each>
							<div class="flex flex-row">
								<xsl:choose>
									<xsl:when test="current-group()/self::*[@rendition='#lc'] or current-group()/self::*[@rendition='#rc']">
										<div class="flex flex-col items-center basis-6/12">
											<xsl:for-each select="current-group()">
												<xsl:apply-templates select="self::*[@rendition='#lc']"/>
											</xsl:for-each>
										</div>
										<div class="flex flex-col items-center basis-6/12">
											<xsl:for-each select="current-group()">
												<xsl:apply-templates select="self::*[@rendition='#rc']"/>
											</xsl:for-each>
										</div>
									</xsl:when>
									<xsl:when test="current-group()/self::*[rendition='#f'] or current-group()/self::*[rendition='#fc']">
										<div class="flex flex-col items-center basis-full">
											<xsl:for-each select="current-group()">
												<xsl:apply-templates select="self::*[rendition='#f']|self::*[rendition='#fc']"/>
											</xsl:for-each>
										</div>
									</xsl:when>
								</xsl:choose>
							</div>
							<xsl:for-each select="current-group()">
								<xsl:apply-templates select="self::tei:fw"/>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:for-each-group>
				</div>
			</div>
		</div>
		<div class="basis-6/12 facsimiles">
			<div id="viewer-1" class="sticky top-4">
				<div id="container_facs_1">
				</div>
			</div>
		</div>
	</div>
	<div>
		<p id="{local:makeId(.)}" style="text-align:center;">
			<xsl:for-each select=".//tei:note[not(./tei:p)]">
			<div class="footnotes" id="{local:makeId(.)}">
				<a>
						<xsl:attribute name="id">
								<xsl:text>fn</xsl:text>
								<xsl:number level="any" format="1" count="tei:note"/>
						</xsl:attribute>
						<xsl:attribute name="href">
								<xsl:text>#fna_</xsl:text>
								<xsl:number level="any" format="1" count="tei:note"/>
						</xsl:attribute>
						<span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
								<xsl:number level="any" format="1" count="tei:note"/>
						</span>
				</a>
				<xsl:apply-templates/>
			</div>
			</xsl:for-each>
		</p>
	</div>
</div>
<xsl:for-each select="//tei:back">
<div class="tei-back">
    <xsl:apply-templates/>
</div>
</xsl:for-each>

</xsl:template>

<xsl:template match="//text()[parent::tei:p[ancestor::tei:body]]|
										//text()[parent::tei:ab[ancestor::tei:body]]|
										//text()[parent::tei:head[ancestor::tei:body]]">
	<xsl:choose>
		<xsl:when test="following-sibling::tei:*[1]/@break='no'">
			<xsl:value-of select="replace(., '\s+$', '')"/>
		</xsl:when>
		<xsl:when test="matches(., '=$', 'm')">
			<xsl:value-of select="replace(., '\s+$', '')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:docTitle">
	<div class="title-page py-4 text-lg" id="#top_page">
		<xsl:apply-templates/>
	</div>
</xsl:template>

<xsl:template match="tei:titlePart">
	<xsl:choose>
		<xsl:when test="@type='count-date-normalized' or @type='num'">
			<h5 id="{local:makeId(.)}" class="yes-index text-center py-4 text-2xl"><xsl:apply-templates/></h5>
		</xsl:when>
		<xsl:when test="@type='main-title' or @type='main'">
			<h4	id="{local:makeId(.)}" class="yes-index text-center py-4 text-4xl"><xsl:apply-templates/></h4>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:milestone">
	<hr class="mx-10 p-4 border-gray-500"/>
</xsl:template>

<xsl:template match="tei:imprimatur">
	<div id="{local:makeId(.)}">
		<p id="{local:makeId(.)}" class="yes-index italic text-center py-4 text-lg"><xsl:apply-templates/></p>
	</div>
</xsl:template>

<xsl:template match="tei:head">
	<h5 id="{local:makeId(.)}" class="yes-index text-center font-semibold text-lg">
		<xsl:apply-templates/>
	</h5>
</xsl:template>

<xsl:template match="tei:lb">
	<br class="linebreak"/>
</xsl:template>

<xsl:template match="tei:w">
	<xsl:apply-templates/>
	<xsl:if test="following-sibling::*[1][@break]">
		<span class="linebreak"><xsl:text>=</xsl:text></span>
	</xsl:if>
	<xsl:if test="self::tei:w[not(following-sibling::tei:w)]/parent::tei:item/following-sibling::*[1][@break]">
		<xsl:text>=</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="tei:fw[@type='catch']">
	<div id="{local:makeId(.)}" class="basis-full float-right text-right px-4">
		<span id="{local:makeId(.)}" class="yes-index text-lg">
			<xsl:apply-templates/>
		</span>
	</div>
</xsl:template>

<xsl:template match="tei:ab">
	<xsl:choose>
		<xsl:when test="@type='catch-word'">
			<div id="{local:makeId(.)}" class="grid-item w-[100%] text-end">
				<h5 id="{local:makeId(.)}" class="yes-index catch-word text-lg">
						<xsl:apply-templates/>
				</h5>
			</div>
		</xsl:when>
		<xsl:when test="@type='imprint' and not(contains(@facs, 'facs_1_'))">
			<div id="{local:makeId(.)}">
				<h5 id="{local:makeId(.)}" class="italic yes-index text-xl text-center">
						<xsl:apply-templates/>
				</h5>
			</div>
		</xsl:when>
		<xsl:when test="@type='count-date' and not(contains(@facs, 'facs_1_'))">
			<div id="{local:makeId(.)}">
				<h4 id="{local:makeId(.)}" class="yes-index text-2xl text-center">
						<xsl:apply-templates/>
				</h4>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div id="{local:makeId(.)}">
			<h5 id="{local:makeId(.)}" class="yes-index text-lg">
					<xsl:apply-templates/>
			</h5>
			</div>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="tei:p">
	<p id="{local:makeId(.)}" class="yes-index text-justify text-lg py-2 px-4">
		<xsl:apply-templates/>
		<!--<xsl:if test="following-sibling::tei:p[@prev]">
				<xsl:if test="following-sibling::*[1]/name() = 'pb'">
						<xsl:for-each select="following-sibling::*[1]">
								<span class="anchor-pb"></span>
								<span class="pb lightgrey" source="{@facs}">[<xsl:value-of select="./@n"/>]</span>
						</xsl:for-each>
				</xsl:if>
				<xsl:for-each select="following-sibling::tei:p[@prev]">
						<xsl:apply-templates/>
				</xsl:for-each>
		</xsl:if>-->
	</p>
</xsl:template>

<xsl:template match="tei:list">
	<ul class="p-4" id="{local:makeId(.)}">
		<xsl:apply-templates/>
	</ul>
</xsl:template>

<xsl:template match="tei:item">
	<li class="yes-index text-lg {if(preceding-sibling::*[1]/@break = 'no') then 'ml-4' else ''}">
		<xsl:apply-templates/>
	</li>
</xsl:template>

<!--<xsl:template match="tei:p[@prev]"/>-->

<!--<xsl:template match="tei:pb[following-sibling::tei:p[@prev]]"/>-->

<!--    <xsl:template match="tei:div">
		<!-\-<div id="{local:makeId(.)}">
				<xsl:apply-templates/>
		</div>-\->
		<xsl:apply-templates/>
</xsl:template>  -->

</xsl:stylesheet>
