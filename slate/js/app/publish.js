/* eslint-disable strict */

const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const markdownIt = require('markdown-it');
const markdownItAttrs = require('markdown-it-attrs');
const markdownItAnchor = require('markdown-it-anchor');
const slugify = require('slugify');
const cheerio = require('cheerio');

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
          // place the title text inside the caption
          $(this).after(`<figcaption>${titleTxt}</figcaption>`);
          // place the caption and the image in a figure
          $(this).wrap(`<figure class="image"></figure>`);
      });
      // set the content to the new content
      content = $.html();
      return content;
    });
    eleventyConfig.addPassthroughCopy(src+"/slate/img");
    eleventyConfig.addPassthroughCopy(src+"/slate/fonts");
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
