# This file has been generated by node2nix 1.6.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "accepts-1.0.7" = {
      name = "accepts";
      packageName = "accepts";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/accepts/-/accepts-1.0.7.tgz";
        sha1 = "5b501fb4f0704309964ccdb048172541208dab1a";
      };
    };
    "asn1-0.1.11" = {
      name = "asn1";
      packageName = "asn1";
      version = "0.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/asn1/-/asn1-0.1.11.tgz";
        sha1 = "559be18376d08a4ec4dbe80877d27818639b2df7";
      };
    };
    "assert-plus-0.1.5" = {
      name = "assert-plus";
      packageName = "assert-plus";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/assert-plus/-/assert-plus-0.1.5.tgz";
        sha1 = "ee74009413002d84cec7219c6ac811812e723160";
      };
    };
    "async-0.9.2" = {
      name = "async";
      packageName = "async";
      version = "0.9.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/async/-/async-0.9.2.tgz";
        sha1 = "aea74d5e61c1f899613bf64bda66d4c78f2fd17d";
      };
    };
    "aws-sign2-0.5.0" = {
      name = "aws-sign2";
      packageName = "aws-sign2";
      version = "0.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.5.0.tgz";
        sha1 = "c57103f7a17fc037f02d7c2e64b602ea223f7d63";
      };
    };
    "balanced-match-1.0.0" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    };
    "block-stream-0.0.9" = {
      name = "block-stream";
      packageName = "block-stream";
      version = "0.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/block-stream/-/block-stream-0.0.9.tgz";
        sha1 = "13ebfe778a03205cfe03751481ebb4b3300c126a";
      };
    };
    "boom-0.4.2" = {
      name = "boom";
      packageName = "boom";
      version = "0.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/boom/-/boom-0.4.2.tgz";
        sha1 = "7a636e9ded4efcefb19cef4947a3c67dfaee911b";
      };
    };
    "brace-expansion-1.1.11" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "1.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha512 = "iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==";
      };
    };
    "buffer-crc32-0.2.3" = {
      name = "buffer-crc32";
      packageName = "buffer-crc32";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-crc32/-/buffer-crc32-0.2.3.tgz";
        sha1 = "bb54519e95d107cbd2400e76d0cab1467336d921";
      };
    };
    "bytes-1.0.0" = {
      name = "bytes";
      packageName = "bytes";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/bytes/-/bytes-1.0.0.tgz";
        sha1 = "3569ede8ba34315fab99c3e92cb04c7220de1fa8";
      };
    };
    "combined-stream-0.0.7" = {
      name = "combined-stream";
      packageName = "combined-stream";
      version = "0.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/combined-stream/-/combined-stream-0.0.7.tgz";
        sha1 = "0137e657baa5a7541c57ac37ac5fc07d73b4dc1f";
      };
    };
    "commander-2.1.0" = {
      name = "commander";
      packageName = "commander";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-2.1.0.tgz";
        sha1 = "d121bbae860d9992a3d517ba96f56588e47c6781";
      };
    };
    "concat-map-0.0.1" = {
      name = "concat-map";
      packageName = "concat-map";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    };
    "cookie-0.1.2" = {
      name = "cookie";
      packageName = "cookie";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cookie/-/cookie-0.1.2.tgz";
        sha1 = "72fec3d24e48a3432073d90c12642005061004b1";
      };
    };
    "cookie-signature-1.0.4" = {
      name = "cookie-signature";
      packageName = "cookie-signature";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/cookie-signature/-/cookie-signature-1.0.4.tgz";
        sha1 = "0edd22286e3a111b9a2a70db363e925e867f6aca";
      };
    };
    "cryptiles-0.2.2" = {
      name = "cryptiles";
      packageName = "cryptiles";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cryptiles/-/cryptiles-0.2.2.tgz";
        sha1 = "ed91ff1f17ad13d3748288594f8a48a0d26f325c";
      };
    };
    "ctype-0.5.3" = {
      name = "ctype";
      packageName = "ctype";
      version = "0.5.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ctype/-/ctype-0.5.3.tgz";
        sha1 = "82c18c2461f74114ef16c135224ad0b9144ca12f";
      };
    };
    "debug-1.0.4" = {
      name = "debug";
      packageName = "debug";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-1.0.4.tgz";
        sha1 = "5b9c256bd54b6ec02283176fa8a0ede6d154cbf8";
      };
    };
    "delayed-stream-0.0.5" = {
      name = "delayed-stream";
      packageName = "delayed-stream";
      version = "0.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/delayed-stream/-/delayed-stream-0.0.5.tgz";
        sha1 = "d4b1f43a93e8296dfe02694f4680bc37a313c73f";
      };
    };
    "depd-0.4.4" = {
      name = "depd";
      packageName = "depd";
      version = "0.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/depd/-/depd-0.4.4.tgz";
        sha1 = "07091fae75f97828d89b4a02a2d4778f0e7c0662";
      };
    };
    "destroy-1.0.3" = {
      name = "destroy";
      packageName = "destroy";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/destroy/-/destroy-1.0.3.tgz";
        sha1 = "b433b4724e71fd8551d9885174851c5fc377e2c9";
      };
    };
    "ee-first-1.0.5" = {
      name = "ee-first";
      packageName = "ee-first";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/ee-first/-/ee-first-1.0.5.tgz";
        sha1 = "8c9b212898d8cd9f1a9436650ce7be202c9e9ff0";
      };
    };
    "escape-html-1.0.1" = {
      name = "escape-html";
      packageName = "escape-html";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-html/-/escape-html-1.0.1.tgz";
        sha1 = "181a286ead397a39a92857cfb1d43052e356bff0";
      };
    };
    "finalhandler-0.1.0" = {
      name = "finalhandler";
      packageName = "finalhandler";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/finalhandler/-/finalhandler-0.1.0.tgz";
        sha1 = "da05bbc4f5f4a30c84ce1d91f3c154007c4e9daa";
      };
    };
    "forever-agent-0.5.2" = {
      name = "forever-agent";
      packageName = "forever-agent";
      version = "0.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/forever-agent/-/forever-agent-0.5.2.tgz";
        sha1 = "6d0e09c4921f94a27f63d3b49c5feff1ea4c5130";
      };
    };
    "form-data-0.1.4" = {
      name = "form-data";
      packageName = "form-data";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/form-data/-/form-data-0.1.4.tgz";
        sha1 = "91abd788aba9702b1aabfa8bc01031a2ac9e3b12";
      };
    };
    "fresh-0.2.2" = {
      name = "fresh";
      packageName = "fresh";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fresh/-/fresh-0.2.2.tgz";
        sha1 = "9731dcf5678c7faeb44fb903c4f72df55187fa77";
      };
    };
    "fs.realpath-1.0.0" = {
      name = "fs.realpath";
      packageName = "fs.realpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    };
    "fstream-0.1.31" = {
      name = "fstream";
      packageName = "fstream";
      version = "0.1.31";
      src = fetchurl {
        url = "https://registry.npmjs.org/fstream/-/fstream-0.1.31.tgz";
        sha1 = "7337f058fbbbbefa8c9f561a28cab0849202c988";
      };
    };
    "glob-7.1.2" = {
      name = "glob";
      packageName = "glob";
      version = "7.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.2.tgz";
        sha512 = "MJTUg1kjuLeQCJ+ccE4Vpa6kKVXkPYJ2mOCQyUuKLcLQsdrMCpBPUi8qVE6+YuaJkozeA9NusTAw3hLr8Xe5EQ==";
      };
    };
    "graceful-fs-3.0.11" = {
      name = "graceful-fs";
      packageName = "graceful-fs";
      version = "3.0.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-3.0.11.tgz";
        sha1 = "7613c778a1afea62f25c630a086d7f3acbbdd818";
      };
    };
    "hawk-1.0.0" = {
      name = "hawk";
      packageName = "hawk";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/hawk/-/hawk-1.0.0.tgz";
        sha1 = "b90bb169807285411da7ffcb8dd2598502d3b52d";
      };
    };
    "hoek-0.9.1" = {
      name = "hoek";
      packageName = "hoek";
      version = "0.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/hoek/-/hoek-0.9.1.tgz";
        sha1 = "3d322462badf07716ea7eb85baf88079cddce505";
      };
    };
    "http-signature-0.10.1" = {
      name = "http-signature";
      packageName = "http-signature";
      version = "0.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-signature/-/http-signature-0.10.1.tgz";
        sha1 = "4fbdac132559aa8323121e540779c0a012b27e66";
      };
    };
    "iconv-lite-0.4.4" = {
      name = "iconv-lite";
      packageName = "iconv-lite";
      version = "0.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.4.4.tgz";
        sha1 = "e95f2e41db0735fc21652f7827a5ee32e63c83a8";
      };
    };
    "inflight-1.0.6" = {
      name = "inflight";
      packageName = "inflight";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    };
    "inherits-2.0.3" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.3.tgz";
        sha1 = "633c2c83e3da42a502f52466022480f4208261de";
      };
    };
    "ipaddr.js-0.1.2" = {
      name = "ipaddr.js";
      packageName = "ipaddr.js";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ipaddr.js/-/ipaddr.js-0.1.2.tgz";
        sha1 = "6a1fd3d854f5002965c34d7bbcd9b4a8d4b0467e";
      };
    };
    "json-stringify-safe-5.0.1" = {
      name = "json-stringify-safe";
      packageName = "json-stringify-safe";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
        sha1 = "1296a2d58fd45f19a0f6ce01d65701e2c735b6eb";
      };
    };
    "media-typer-0.2.0" = {
      name = "media-typer";
      packageName = "media-typer";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/media-typer/-/media-typer-0.2.0.tgz";
        sha1 = "d8a065213adfeaa2e76321a2b6dda36ff6335984";
      };
    };
    "merge-descriptors-0.0.2" = {
      name = "merge-descriptors";
      packageName = "merge-descriptors";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/merge-descriptors/-/merge-descriptors-0.0.2.tgz";
        sha1 = "c36a52a781437513c57275f39dd9d317514ac8c7";
      };
    };
    "methods-1.1.0" = {
      name = "methods";
      packageName = "methods";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/methods/-/methods-1.1.0.tgz";
        sha1 = "5dca4ee12df52ff3b056145986a8f01cbc86436f";
      };
    };
    "mime-1.2.11" = {
      name = "mime";
      packageName = "mime";
      version = "1.2.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime/-/mime-1.2.11.tgz";
        sha1 = "58203eed86e3a5ef17aed2b7d9ebd47f0a60dd10";
      };
    };
    "mime-types-1.0.2" = {
      name = "mime-types";
      packageName = "mime-types";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime-types/-/mime-types-1.0.2.tgz";
        sha1 = "995ae1392ab8affcbfcb2641dd054e943c0d5dce";
      };
    };
    "minimatch-3.0.4" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha512 = "yJHVQEhyqPLUTgt9B83PXu6W3rx4MvvHvSUvToogpwoGDOUQ+yDrR0HRot+yOCdCO7u4hX3pWft6kWBBcqh0UA==";
      };
    };
    "minimist-0.0.8" = {
      name = "minimist";
      packageName = "minimist";
      version = "0.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz";
        sha1 = "857fcabfc3397d2625b8228262e86aa7a011b05d";
      };
    };
    "mkdirp-0.5.1" = {
      name = "mkdirp";
      packageName = "mkdirp";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mkdirp/-/mkdirp-0.5.1.tgz";
        sha1 = "30057438eac6cf7f8c4767f38648d6697d75c903";
      };
    };
    "ms-0.6.2" = {
      name = "ms";
      packageName = "ms";
      version = "0.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-0.6.2.tgz";
        sha1 = "d89c2124c6fdc1353d65a8b77bf1aac4b193708c";
      };
    };
    "nan-1.0.0" = {
      name = "nan";
      packageName = "nan";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/nan/-/nan-1.0.0.tgz";
        sha1 = "ae24f8850818d662fcab5acf7f3b95bfaa2ccf38";
      };
    };
    "natives-1.1.4" = {
      name = "natives";
      packageName = "natives";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/natives/-/natives-1.1.4.tgz";
        sha512 = "Q29yeg9aFKwhLVdkTAejM/HvYG0Y1Am1+HUkFQGn5k2j8GS+v60TVmZh6nujpEAj/qql+wGUrlryO8bF+b1jEg==";
      };
    };
    "negotiator-0.4.7" = {
      name = "negotiator";
      packageName = "negotiator";
      version = "0.4.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/negotiator/-/negotiator-0.4.7.tgz";
        sha1 = "a4160f7177ec806738631d0d3052325da42abdc8";
      };
    };
    "node-uuid-1.4.8" = {
      name = "node-uuid";
      packageName = "node-uuid";
      version = "1.4.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-uuid/-/node-uuid-1.4.8.tgz";
        sha1 = "b040eb0923968afabf8d32fb1f17f1167fdab907";
      };
    };
    "oauth-sign-0.3.0" = {
      name = "oauth-sign";
      packageName = "oauth-sign";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.3.0.tgz";
        sha1 = "cb540f93bb2b22a7d5941691a288d60e8ea9386e";
      };
    };
    "on-finished-2.1.0" = {
      name = "on-finished";
      packageName = "on-finished";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/on-finished/-/on-finished-2.1.0.tgz";
        sha1 = "0c539f09291e8ffadde0c8a25850fb2cedc7022d";
      };
    };
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
      };
    };
    "options-0.0.6" = {
      name = "options";
      packageName = "options";
      version = "0.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/options/-/options-0.0.6.tgz";
        sha1 = "ec22d312806bb53e731773e7cdaefcf1c643128f";
      };
    };
    "parseurl-1.3.2" = {
      name = "parseurl";
      packageName = "parseurl";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/parseurl/-/parseurl-1.3.2.tgz";
        sha1 = "fc289d4ed8993119460c156253262cdc8de65bf3";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    };
    "path-to-regexp-0.1.3" = {
      name = "path-to-regexp";
      packageName = "path-to-regexp";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-to-regexp/-/path-to-regexp-0.1.3.tgz";
        sha1 = "21b9ab82274279de25b156ea08fd12ca51b8aecb";
      };
    };
    "proxy-addr-1.0.1" = {
      name = "proxy-addr";
      packageName = "proxy-addr";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/proxy-addr/-/proxy-addr-1.0.1.tgz";
        sha1 = "c7c566d5eb4e3fad67eeb9c77c5558ccc39b88a8";
      };
    };
    "psl-1.1.28" = {
      name = "psl";
      packageName = "psl";
      version = "1.1.28";
      src = fetchurl {
        url = "https://registry.npmjs.org/psl/-/psl-1.1.28.tgz";
        sha512 = "+AqO1Ae+N/4r7Rvchrdm432afjT9hqJRyBN3DQv9At0tPz4hIFSGKbq64fN9dVoCow4oggIIax5/iONx0r9hZw==";
      };
    };
    "punycode-1.4.1" = {
      name = "punycode";
      packageName = "punycode";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/punycode/-/punycode-1.4.1.tgz";
        sha1 = "c0d5a63b2718800ad8e1eb0fa5269c84dd41845e";
      };
    };
    "qs-0.6.6" = {
      name = "qs";
      packageName = "qs";
      version = "0.6.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/qs/-/qs-0.6.6.tgz";
        sha1 = "6e015098ff51968b8a3c819001d5f2c89bc4b107";
      };
    };
    "qs-2.2.2" = {
      name = "qs";
      packageName = "qs";
      version = "2.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/qs/-/qs-2.2.2.tgz";
        sha1 = "dfe783f1854b1ac2b3ade92775ad03e27e03218c";
      };
    };
    "range-parser-1.0.0" = {
      name = "range-parser";
      packageName = "range-parser";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/range-parser/-/range-parser-1.0.0.tgz";
        sha1 = "a4b264cfe0be5ce36abe3765ac9c2a248746dbc0";
      };
    };
    "raw-body-1.3.0" = {
      name = "raw-body";
      packageName = "raw-body";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/raw-body/-/raw-body-1.3.0.tgz";
        sha1 = "978230a156a5548f42eef14de22d0f4f610083d1";
      };
    };
    "rimraf-2.6.2" = {
      name = "rimraf";
      packageName = "rimraf";
      version = "2.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/rimraf/-/rimraf-2.6.2.tgz";
        sha512 = "lreewLK/BlghmxtfH36YYVg1i8IAce4TI7oao75I1g245+6BctqTVQiBP3YUJ9C6DQOXJmkYR9X9fCLtCOJc5w==";
      };
    };
    "send-0.8.5" = {
      name = "send";
      packageName = "send";
      version = "0.8.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/send/-/send-0.8.5.tgz";
        sha1 = "37f708216e6f50c175e74c69fec53484e2fd82c7";
      };
    };
    "serve-static-1.5.4" = {
      name = "serve-static";
      packageName = "serve-static";
      version = "1.5.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/serve-static/-/serve-static-1.5.4.tgz";
        sha1 = "819fb37ae46bd02dd520b77fcf7fd8f5112f9782";
      };
    };
    "sntp-0.2.4" = {
      name = "sntp";
      packageName = "sntp";
      version = "0.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/sntp/-/sntp-0.2.4.tgz";
        sha1 = "fb885f18b0f3aad189f824862536bceeec750900";
      };
    };
    "tinycolor-0.0.1" = {
      name = "tinycolor";
      packageName = "tinycolor";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/tinycolor/-/tinycolor-0.0.1.tgz";
        sha1 = "320b5a52d83abb5978d81a3e887d4aefb15a6164";
      };
    };
    "tough-cookie-2.4.3" = {
      name = "tough-cookie";
      packageName = "tough-cookie";
      version = "2.4.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/tough-cookie/-/tough-cookie-2.4.3.tgz";
        sha512 = "Q5srk/4vDM54WJsJio3XNn6K2sCG+CQ8G5Wz6bZhRZoAe/+TxjWB/GlFAnYEbkYVlON9FMk/fE3h2RLpPXo4lQ==";
      };
    };
    "tunnel-agent-0.3.0" = {
      name = "tunnel-agent";
      packageName = "tunnel-agent";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.3.0.tgz";
        sha1 = "ad681b68f5321ad2827c4cfb1b7d5df2cfe942ee";
      };
    };
    "type-is-1.3.2" = {
      name = "type-is";
      packageName = "type-is";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/type-is/-/type-is-1.3.2.tgz";
        sha1 = "4f2a5dc58775ca1630250afc7186f8b36309d1bb";
      };
    };
    "utils-merge-1.0.0" = {
      name = "utils-merge";
      packageName = "utils-merge";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/utils-merge/-/utils-merge-1.0.0.tgz";
        sha1 = "0294fb922bb9375153541c4f7096231f287c8af8";
      };
    };
    "vary-0.1.0" = {
      name = "vary";
      packageName = "vary";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vary/-/vary-0.1.0.tgz";
        sha1 = "df0945899e93c0cc5bd18cc8321d9d21e74f6176";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
      };
    };
  };
in
{
  "body-parser-~1.6.3" = nodeEnv.buildNodePackage {
    name = "body-parser";
    packageName = "body-parser";
    version = "1.6.7";
    src = fetchurl {
      url = "https://registry.npmjs.org/body-parser/-/body-parser-1.6.7.tgz";
      sha1 = "82306becadf44543e826b3907eae93f0237c4e5c";
    };
    dependencies = [
      sources."bytes-1.0.0"
      sources."depd-0.4.4"
      sources."ee-first-1.0.5"
      sources."iconv-lite-0.4.4"
      sources."media-typer-0.2.0"
      sources."mime-types-1.0.2"
      sources."on-finished-2.1.0"
      sources."qs-2.2.2"
      sources."raw-body-1.3.0"
      sources."type-is-1.3.2"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Node.js body parsing middleware";
      homepage = https://github.com/expressjs/body-parser;
      license = "MIT";
    };
    production = true;
    bypassCache = false;
  };
  "express-~4.8.3" = nodeEnv.buildNodePackage {
    name = "express";
    packageName = "express";
    version = "4.8.8";
    src = fetchurl {
      url = "https://registry.npmjs.org/express/-/express-4.8.8.tgz";
      sha1 = "6aba348ccdfa87608040b12ca0010107a0aac28e";
    };
    dependencies = [
      sources."accepts-1.0.7"
      sources."buffer-crc32-0.2.3"
      sources."cookie-0.1.2"
      sources."cookie-signature-1.0.4"
      sources."debug-1.0.4"
      sources."depd-0.4.4"
      sources."destroy-1.0.3"
      sources."ee-first-1.0.5"
      sources."escape-html-1.0.1"
      sources."finalhandler-0.1.0"
      sources."fresh-0.2.2"
      sources."ipaddr.js-0.1.2"
      sources."media-typer-0.2.0"
      sources."merge-descriptors-0.0.2"
      sources."methods-1.1.0"
      sources."mime-1.2.11"
      sources."mime-types-1.0.2"
      sources."ms-0.6.2"
      sources."negotiator-0.4.7"
      sources."on-finished-2.1.0"
      sources."parseurl-1.3.2"
      sources."path-to-regexp-0.1.3"
      sources."proxy-addr-1.0.1"
      sources."qs-2.2.2"
      sources."range-parser-1.0.0"
      sources."send-0.8.5"
      sources."serve-static-1.5.4"
      sources."type-is-1.3.2"
      sources."utils-merge-1.0.0"
      sources."vary-0.1.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Fast, unopinionated, minimalist web framework";
      homepage = http://expressjs.com/;
      license = "MIT";
    };
    production = true;
    bypassCache = false;
  };
  "request-~2.34.0" = nodeEnv.buildNodePackage {
    name = "request";
    packageName = "request";
    version = "2.34.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/request/-/request-2.34.0.tgz";
      sha1 = "b5d8b9526add4a2d4629f4d417124573996445ae";
    };
    dependencies = [
      sources."asn1-0.1.11"
      sources."assert-plus-0.1.5"
      sources."async-0.9.2"
      sources."aws-sign2-0.5.0"
      sources."boom-0.4.2"
      sources."combined-stream-0.0.7"
      sources."cryptiles-0.2.2"
      sources."ctype-0.5.3"
      sources."delayed-stream-0.0.5"
      sources."forever-agent-0.5.2"
      sources."form-data-0.1.4"
      sources."hawk-1.0.0"
      sources."hoek-0.9.1"
      sources."http-signature-0.10.1"
      sources."json-stringify-safe-5.0.1"
      sources."mime-1.2.11"
      sources."node-uuid-1.4.8"
      sources."oauth-sign-0.3.0"
      sources."psl-1.1.28"
      sources."punycode-1.4.1"
      sources."qs-0.6.6"
      sources."sntp-0.2.4"
      sources."tough-cookie-2.4.3"
      sources."tunnel-agent-0.3.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Simplified HTTP request client.";
      homepage = https://github.com/mikeal/request;
      license = "Apache, Version 2.0";
    };
    production = true;
    bypassCache = false;
  };
  "tar-~0.1.19" = nodeEnv.buildNodePackage {
    name = "tar";
    packageName = "tar";
    version = "0.1.20";
    src = fetchurl {
      url = "https://registry.npmjs.org/tar/-/tar-0.1.20.tgz";
      sha1 = "42940bae5b5f22c74483699126f9f3f27449cb13";
    };
    dependencies = [
      sources."balanced-match-1.0.0"
      sources."block-stream-0.0.9"
      sources."brace-expansion-1.1.11"
      sources."concat-map-0.0.1"
      sources."fs.realpath-1.0.0"
      sources."fstream-0.1.31"
      sources."glob-7.1.2"
      sources."graceful-fs-3.0.11"
      sources."inflight-1.0.6"
      sources."inherits-2.0.3"
      sources."minimatch-3.0.4"
      sources."minimist-0.0.8"
      sources."mkdirp-0.5.1"
      sources."natives-1.1.4"
      sources."once-1.4.0"
      sources."path-is-absolute-1.0.1"
      sources."rimraf-2.6.2"
      sources."wrappy-1.0.2"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "tar for node";
      homepage = https://github.com/isaacs/node-tar;
      license = "BSD";
    };
    production = true;
    bypassCache = false;
  };
  "ws-~0.4.32" = nodeEnv.buildNodePackage {
    name = "ws";
    packageName = "ws";
    version = "0.4.32";
    src = fetchurl {
      url = "https://registry.npmjs.org/ws/-/ws-0.4.32.tgz";
      sha1 = "787a6154414f3c99ed83c5772153b20feb0cec32";
    };
    dependencies = [
      sources."commander-2.1.0"
      sources."nan-1.0.0"
      sources."options-0.0.6"
      sources."tinycolor-0.0.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "simple to use, blazing fast and thoroughly tested websocket client, server and console for node.js, up-to-date against RFC-6455";
      homepage = https://github.com/einaros/ws;
    };
    production = true;
    bypassCache = false;
  };
}