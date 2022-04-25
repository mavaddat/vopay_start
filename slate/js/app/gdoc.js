/* eslint-disable strict */
// require @googleapis/docs
const { Docs } = require('@googleapis/docs');
const fs = require('fs');

// get a list of the files in the source directory
const files = fs.readdirSync('./out');

// authenticate using google app credentials
const docs = new Docs({
    version: 'v1',
    auth: {
        keyFile: 'G:/My Drive/velvety-gearbox-338704-6472131fc5e6.json',
        scopes: ['https://www.googleapis.com/auth/documents']
    }
});

// foreach file in the source directory, check if a document with the same base filename exists in google docs
files.forEach(file => {
    const base = file.replace('.html', '');
    // TODO: convert all svgs into emf files
    docs.documents.get({
        documentId: `1w3-_${base}`
    }).then(() => {
        // if the document exists, update it
        docs.documents.update({
            documentId: `1w3-_${base}`,
            resource: {
                body: {
                    content: fs.readFileSync(`./out/${file}`, 'utf8')
                }
            }
        }).then(() => {
            console.log(`updated ${file}`);
        }).catch(err => {
            console.log(err);
        });
    }).catch(err => {
        // if the document doesn't exist, create it
        if (err.code === 404) {
            docs.documents.create({
                documentId: `1w3-_${base}`,
                resource: {
                    body: {
                        content: fs.readFileSync(`./out/${file}`, 'utf8')
                    }
                }
            }).then(() => {
                console.log(`created ${file}`);
            }).catch(err => {
                console.log(err);
            });
        }
    });
});
