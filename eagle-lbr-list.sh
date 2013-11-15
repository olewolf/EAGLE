#!/bin/bash
#
# Dump the contents of an EAGLE library to text.
#

LIBRARY=$1

XSLFILE=$(mktemp)
cat > ${XSLFILE} <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" />

  <xsl:template match="/">
	<dl>
	  <xsl:for-each select="eagle/drawing/library/devicesets/deviceset">
		<dt><b><xsl:value-of select="@name" /></b></dt>
		<dd><xsl:value-of select="description" /></dd>
      </xsl:for-each>
	</dl>
  </xsl:template>

</xsl:stylesheet>
EOF

xalan -xsl ${XSLFILE} -in "${LIBRARY}" | sed 's/&lt;/</g' | sed 's/&gt;/>/g' | lynx --dump -stdin
