/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'sql-dark': '#1e1e1e',
        'sql-darker': '#141414',
        'sql-accent': '#007acc',
        'sql-green': '#4ec9b0',
        'sql-orange': '#ce9178',
        'sql-purple': '#c586c0',
      },
    },
  },
  plugins: [],
}
