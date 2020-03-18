// http://eslint.org/docs/rules/
// Good summary at https://gist.github.com/cletusw/e01a85e399ab563b1236
module.exports = {
    "extends": "airbnb",
    "plugins": [
        "react",
        "jsx-a11y",
        "import",
        "react-hooks"
    ],
    "rules": {
      "semi": 0,                      // require or disallow use of semicolons instead of ASI
      "no-extra-semi": 0,
      "prefer-const": 0,
      "object-curly-spacing": 0,
      "no-underscore-dangle": 0,
      "react-hooks/rules-of-hooks": "error",
      "react-hooks/exhaustive-deps": "warn"
    }
};
