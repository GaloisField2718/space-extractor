const fs = require('fs');

// Lire le fichier cookie.json directement depuis SPACE_DL_PATH
const cookiePath = process.env.SPACE_DL_PATH + '/cookie.json';
const cookies = JSON.parse(fs.readFileSync(cookiePath));

console.log('# Netscape HTTP Cookie File');
console.log('# http://curl.haxx.se/rfc/cookie_spec.html');

cookies.forEach(cookie => {
    const { domain, path, secure, expirationDate, name, value } = cookie;
    const expiration = expirationDate ? Math.floor(expirationDate) : '0';
    const secureFlag = secure ? 'TRUE' : 'FALSE';
    console.log(`${domain}\tTRUE\t${path}\t${secureFlag}\t${expiration}\t${name}\t${value}`);
});

