#let config = (
  weight: "regular",       // Font weight
  text-size: 20pt,         // Text size
  box-text-size: 0.8em,    // Box text size
  logo-height: 22%,        // Logo height
)

// Colors
#let colors = (
  red: rgb("#c1002a"),
  gray: rgb("#405a68"),
  green: rgb(31, 136, 61),
  blue: rgb(9, 105, 218),
  purple: rgb(130, 80, 223),
)

// State variables
#let states = (
  title: state("title", []),                // Title
  stitle: state("stitle", []),              // Short title
  author: state("author", []),              // Author
  labo: state("academic-program", []),
  mlogo: state("mlogo", []),                // Main logo
  flogo: state("flogo", []),                // Footer logo
  sec-count: counter("sec-count"),          // Section counter
  app-count: counter("app-count"),          // Appendix counter
  localization: state("localization", []),
)