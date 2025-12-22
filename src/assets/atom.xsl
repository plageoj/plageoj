<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom"
    version="1.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="atom:feed/atom:title" />
                </title>
                <link
                    href="https://fonts.googleapis.com/css2?family=Shippori+Mincho:wght@500&amp;display=swap"
                    rel="stylesheet"
                />
                <link rel="stylesheet" href="assets/index.css" />
            </head>
            <body>
                <h1>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="atom:feed/atom:id" />
                        </xsl:attribute>
                        <xsl:value-of select="atom:feed/atom:title" />
                    </a>
                </h1>
                <p> 最終更新日: <date>
                        <xsl:attribute name="datetime">
                            <xsl:value-of select="atom:feed/atom:updated" />
                        </xsl:attribute>
                        <xsl:value-of
                            select="substring(atom:feed/atom:updated, 1, 10)" />
                    </date>
                </p>
                <xsl:for-each select="atom:feed/atom:entry">
                    <div style="margin-bottom: 2em;">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="atom:link/@href" />
                            </xsl:attribute>
                            <xsl:value-of select="atom:summary" />
                        </a>
                        <p>
                            <small>更新日: <date>
                                    <xsl:attribute name="datetime">
                                        <xsl:value-of select="atom:updated" />
                                    </xsl:attribute>
                                    <xsl:value-of
                                        select="substring(atom:updated, 1, 10)" />
                                </date>
                            </small>
                        </p>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
