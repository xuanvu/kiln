<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--
      Defaults stylesheet. Defines default globals and reads
      parameters from the sitemap.
  -->

  <!-- $filedir is the directory containing the context file. To
       specify the 'root' directory, it's value should be null (and
       not .). Note that directory information can also be included in
       $filename. -->
  <xsl:param name="filedir" select="''" />
  <!-- $filename is the name of the context file. It may include
       directory path information (but must not duplicate any such
       information that is in $filedir). -->
  <xsl:param name="filename" select="''" />
  <!-- $fileextension is the extension part of the *transformed*
       context file's name (and therefore may not match the extension
       as it appears in $filename. -->
  <xsl:param name="fileextension" select="''" />
  <!-- $language is the language code used to distinguish between
       language contexts in a multilingual site. -->
  <xsl:param name="language" select="''" />

  <!-- Specify a mount path if you are mounting the webapp in a
       subdirectory rather than at the root of the domain. This path
       must either be empty or begin with a "/" and not include a
       trailing slash.

       The value is the URL root for the webapp. -->
  <xsl:variable name="kiln:mount-path" select="''" />

  <!-- $kiln:context-path defines the URL root for the webapp. -->
  <xsl:variable name="kiln:context-path">
    <xsl:value-of select="$kiln:mount-path" />
    <xsl:if test="$language">
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$language" />
    </xsl:if>
  </xsl:variable>

  <!-- Base URL for non-textual content (images, video, etc). If these
       are being served by Cocoon, this should be specified as
       relative to $context-path. Otherwise, a full URL including
       protocol and domain is required.

       This URL must not include a trailing slash. -->
  <xsl:variable name="kiln:content-url" select="''" />
  <xsl:variable name="kiln:content-path">
    <xsl:if test="not(starts-with($kiln:content-url, 'http'))">
      <xsl:value-of select="$kiln:mount-path" />
    </xsl:if>
    <xsl:value-of select="$kiln:content-url" />
  </xsl:variable>

  <!-- Base URL for assets (non-content images, CSS, JavaScript,
       etc). If these are being served by Cocoon, this should be
       specified as relative to $context-path. Otherwise, a full URL
       including protocol and domain is required.

       This URL must not include a trailing slash. -->
  <xsl:variable name="kiln:assets-url" select="'/assets'" />
  <xsl:variable name="kiln:assets-path">
    <xsl:if test="not(starts-with($kiln:assets-url, 'http'))">
      <xsl:value-of select="$kiln:mount-path" />
    </xsl:if>
    <xsl:value-of select="$kiln:assets-url" />
  </xsl:variable>

  <!-- Base URL for content images. -->
  <xsl:variable name="kiln:images-url"
    select="concat($kiln:content-path, '/images')" />
  <xsl:variable name="kiln:images-path">
    <xsl:if test="not(starts-with($kiln:images-url, 'http'))">
      <xsl:value-of select="$kiln:mount-path" />
    </xsl:if>
    <xsl:value-of select="$kiln:images-url" />
  </xsl:variable>

  <xsl:variable name="kiln:pathroot"
                select="concat($kiln:context-path, '/', $filedir)" />
  <xsl:variable name="kiln:path">
    <xsl:value-of select="$kiln:pathroot" />
    <xsl:if test="not(ends-with($kiln:pathroot, '/'))">
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:value-of select="$filename" />
    <xsl:if test="$fileextension">
      <xsl:text>.</xsl:text>
      <xsl:value-of select="$fileextension" />
    </xsl:if>
  </xsl:variable>

</xsl:stylesheet>
