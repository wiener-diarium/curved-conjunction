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
	<div class="flex flex-row my-4 transcript active">
		<div class="basis-6/12 text px-4 .yes-index">
			<div class="section">
				<div class="sticky top-0 flex flex-row bg-cyan-100 rounded">
					<div class="flex basis-1/12 p-2">
						<a href="/curved-conjunction/search" aria-label="Zurück zur Volltextsuche" class="text-gray-500">
							<svg width="16" height="16" fill="currentColor" class="bi bi-arrow-left-square-fill" viewBox="0 0 16 16"><path d="M16 14a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2zm-4.5-6.5H5.707l2.147-2.146a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708-.708L5.707 8.5H11.5a.5.5 0 0 0 0-1"></path></svg>
						</a>
						<a id="show-on-scroll" href="#top_page" aria-label="Zurück zur ersten Seite" class="text-gray-500 fade px-2">
                            <svg width="16" height="16" fill="currentColor" class="bi bi-arrow-up-square" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm8.5 9.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707z"/>
                            </svg>
						</a>
					</div>
					<div class="flex basis-3/12 p-2">
							<!-- <input type="checkbox" name="opt[]" value="separateWordSearch" checked="checked"/>Wörter einzeln suchen -->
							<input type="text" name="keyword" class="mx-2 px-2 border border-gray-200 rounded" placeholder="Schlagwort eingeben..."/>
					</div>
					<ul class="flex flex-row basis-8/12 align-middle justify-center items-center">
                        <li class="px-2">
                            <image-switch opt="es" class="flex"></image-switch>
                        </li>
                        <li class="px-2">
                            <font-size opt="fs"></font-size>
                        </li>
                        <li class="px-2">
                            <font-family opt="ff"></font-family>
                        </li>
                        <li class="px-2">
                            <annotation-slider opt="br"></annotation-slider>
                        </li>
					</ul>
				</div>
				<div class="sticky top-8 flex">
					<div id="mark-scroll" class="fade-lang my-4 bg-white rounded border border-gray-100 p-2">
						<button class="btn text-xl" data-search="next" disabled="disabled">&#x2193;</button>
						<button class="btn text-xl" data-search="prev" disabled="disabled">&#x2191;</button>
						<button class="btn text-xl" data-search="clear" disabled="disabled">✖</button>
						<div id="results-div"></div>
				    </div>
				</div>
				<div class="title-page py-4" id="#top_page">
                    <xsl:apply-templates select=".//tei:front"/>
				</div>
				<xsl:for-each-group select=".//tei:body[tei:div[@type='article']]|.//tei:body/tei:div[@type='page']" group-starting-with="tei:pb">
				<xsl:for-each select="current-group()">
				<div class="grid grid-cols-1 {if(position() = last()) then('margin-end') else()}">
                    <!--<div class="grid-sizer"></div>-->
                    <xsl:apply-templates/>
				</div>
				</xsl:for-each>
				</xsl:for-each-group>
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

    <xsl:template match="tei:titlePart">
        <xsl:choose>
            <xsl:when test="@type='count-date-normalized' or @type='num'">
                <h5 id="{local:makeId(.)}" class="yes-index text-center py-2"><xsl:apply-templates/></h5>
            </xsl:when>
            <xsl:when test="@type='main-title' or @type='main'">
                <h4 id="{local:makeId(.)}" class="yes-index text-center py-2"><xsl:apply-templates/></h4>
            </xsl:when>
            <xsl:when test="@type='imprint'">
                <p id="{local:makeId(.)}" class="yes-index italic text-center py-2"><xsl:apply-templates/></p>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:imprimatur">
        <div id="{local:makeId(.)}">
            <p id="{local:makeId(.)}" class="grid-item yes-index"><xsl:apply-templates/></p>
        </div>
    </xsl:template>

    <xsl:template match="tei:head[parent::tei:div[@type='page']]">
        <div id="{local:makeId(.)}">
            <h5 id="{local:makeId(.)}" class="yes-index text-center">
                <xsl:apply-templates/>
            </h5>
        </div>
    </xsl:template>

    <xsl:template match="tei:head[parent::tei:div[not(@type)] and not(following-sibling::tei:*)]">
        <div id="{local:makeId(.)}">
            <h5 id="{local:makeId(.)}" class="yes-index text-center">
                <xsl:apply-templates/>
            </h5>
        </div>
    </xsl:template>

    <xsl:template match="tei:head"/>

    <xsl:template match="tei:lb">
        <xsl:if test="@break">
            <span class="linebreak"><xsl:text>=</xsl:text></span>
        </xsl:if>
        <br class="linebreak"/>
    </xsl:template>

    <xsl:template match="tei:w">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:pc">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:fw[@type='catch']">
        <div id="{local:makeId(.)}" class="grid-item grid-item--width2 text-end">
            <span id="{local:makeId(.)}" class="yes-index catch-word">
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>
    <xsl:template match="tei:fw[@type='sig']">
        <div id="{local:makeId(.)}" class="grid-item grid-item--width2 text-center">
            <span id="{local:makeId(.)}" class="yes-index catch-word">
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>
    <xsl:template match="tei:fw[@type='pageNum']">
        <div id="{local:makeId(.)}" class="grid-item grid-item--width2 text-center">
            <span id="{local:makeId(.)}" class="yes-index catch-word">
                <xsl:apply-templates/>
            </span>
        </div>
    </xsl:template>

    <xsl:template match="tei:ab">

        <xsl:choose>
            <xsl:when test="@type='list'">
                <div id="{local:makeId(.)}">
                <ul>
                    <xsl:for-each-group select="node()" group-starting-with="tei:lb">
                        <xsl:if test="position() > 1">
                        <li class="yes-index"
                            data-zone="{current-group()/self::tei:lb/@facs}"
                            data-num="{current-group()/self::tei:lb/@n}">
                            <xsl:value-of select="current-group()/self::text()"/>
                        </li>
                        </xsl:if>
                    </xsl:for-each-group>
                </ul>
                </div>
            </xsl:when>
            <xsl:when test="@type='catch-word'">
                <div id="{local:makeId(.)}" class="grid-item grid-item--width2 text-end">
                <span id="{local:makeId(.)}" class="yes-index catch-word">
                    <xsl:apply-templates/>
                </span>
                </div>
            </xsl:when>
            <xsl:when test="@type='imprint' and not(contains(@facs, 'facs_1_'))">
                <div id="{local:makeId(.)}">
                <span id="{local:makeId(.)}" class="italic yes-index catch-word">
                    <xsl:apply-templates/>
                </span>
                </div>
            </xsl:when>
            <xsl:when test="@type='count-date' and not(contains(@facs, 'facs_1_'))">
                <div id="{local:makeId(.)}">
                <h4 id="{local:makeId(.)}" class="yes-index count-date">
                    <xsl:apply-templates/>
                </h4>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="{local:makeId(.)}">
                <span id="{local:makeId(.)}" class="yes-index">
                    <xsl:apply-templates/>
                </span>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:p">
        <div>
            <xsl:if test="preceding-sibling::*[1]/name() = 'head'">
                <xsl:for-each select="preceding-sibling::*[1]">
                    <h5 id="{local:makeId(.)}" class="yes-index text-center">
                    <xsl:apply-templates/>
                    </h5>
                </xsl:for-each>
            </xsl:if>
            <p id="{local:makeId(.)}" class="yes-index">
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
        </div>
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
