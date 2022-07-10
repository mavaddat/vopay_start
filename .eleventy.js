'use strict';

const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const markdownIt = require('markdown-it');
const markdownItAttrs = require('markdown-it-attrs');
const markdownItAnchor = require('markdown-it-anchor');
const slugify = require('slugify');
const cheerio = require('cheerio');
const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const { window } = new JSDOM('<html></html>');
var $ = require('jquery')(window);
module.exports = function(eleventyConfig) {
  const src = process.env.SLATEDIR || 'source';
  eleventyConfig.setUseGitIgnore(false);
  eleventyConfig.addTransform("autocaption", function(content, outputPath) {
    const $ = cheerio.load(content);
    $('img.autocaption').each(function() {
        // get the title text
        const titleTxt = $(this).attr('title');
        // remove the title attribute
        $(this).removeAttr('title');
        // place the figcaption and the image in a figure
        $(this).wrap(`<figure></figure>`);
        // place the title text inside the caption
        $(this).after(`<figcaption>${titleTxt}</figcaption>`);
        // add the figcaption to the figure
        $(this).parent().append($(this).next());
        $(this).parent().wrap(`<div class="autocaption"></div>`);
    });
    // set the content to the new content
    content = $.html();
    return content;
  });
  eleventyConfig.addPassthroughCopy(src+"/slate/css/*.css");
  eleventyConfig.addPassthroughCopy(src+"/slate/js");
  eleventyConfig.addPassthroughCopy(src+"/slate/img");
  eleventyConfig.addPassthroughCopy(src+"/slate/fonts");
  // copy jquery.min.js from node_modules to the slate/js/lib folder
  //eleventyConfig.addPassthroughCopy({"node_modules/jquery/dist/jquery.min.js":"slate/js/lib/jquery.min.js"});
  // copy lunr.js from node_modules to the slate/js/lib folder
  //eleventyConfig.addPassthroughCopy({"node_modules/lunr/lunr.min.js":"slate/js/lib/lunr.min.js"});
  // copy imagesloaded from node_modules to the slate/js/lib folder
    eleventyConfig.addPassthroughCopy({"node_modules/imagesloaded/imagesloaded.pkgd.min.js":"slate/js/lib/imagesloaded.pkgd.min.js"});
  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.setLibrary("md",
    markdownIt({
      html: true,
      linkify: true,
      typographer: true
    }).use(markdownItAnchor, {
        slugify: s => slugify(s, {remove: /[*+~.()'"!:@]/g, strict: true})
    }).use(markdownItAttrs, {
        // optional, these are default options
        leftDelimiter: '{',
        rightDelimiter: '}',
        allowedAttributes: []  // empty array => all attributes are allowed
      })
  );
};
