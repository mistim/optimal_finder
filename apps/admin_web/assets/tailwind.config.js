// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
const colors = require("tailwindcss/colors");
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
    "../../../deps/petal_components/**/*.*ex",
  ],
  theme: {
    screens: {
      xs: '480px',
      sm: '640px',
      md: '768px',
      lg: '976px',
      xl: '1280px',
      '2xl': '1536px',
      'tablet': '640px',
      'desktop': '1280px',
      'portrait': {'raw': '(orientation: portrait)'}
    },
    extend: {
      boxShadow: {
        border: '0 2px 0 0 #181b21'
      },
      colors: {
        primary: colors.blue,
        secondary: colors.pink,
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
