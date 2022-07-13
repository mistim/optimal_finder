// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
    "../../../deps/petal_components/**/*.*ex",
  ],
  theme: {
    screens: {
      sm: '480px',
      md: '768px',
      lg: '976px',
      xl: '1440px',
      'tablet': '600px',
      'desktop': '1200px',
      'portrait': {'raw': '(orientation: portrait)'}
    },
    extend: {
      boxShadow: {
        border: '0 2px 0 0 #181b21'
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
