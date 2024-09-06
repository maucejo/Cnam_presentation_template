#import "@preview/polylux:0.3.1": *
#import "_boxes.typ": *
#import "_slides.typ": *

#let presentation(
  aspect-ratio: "16-9",
  title: [Title],
  short-title: "",
  author: none,
  laboratory: "",
  lang: "fr",
  logo: image("resources/assets/logo_cnam_lmssc.png"),
  footer-logo: image("resources/assets/lecnam.png"),
  font: "Lato",
  math-font: "Lete Sans Math",
  body
) = {
  set text(font: font, weight: config.weight, size: config.text-size, number-type: "lining", lang: lang)
  set strong(delta: 200)
  set par(justify: true)

  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
    fill: colors.gray.lighten(95%),
  )

  // localization
  let localization = json("resources/i18n/fr.json")
  if lang == "en" {
      localization = json("resources/i18n/en.json")
  }

  show math.equation: set text(font: math-font, weight: config.weight, stylistic-set: 1)
  set list(marker: ([#text(fill:colors.red)[#sym.bullet]], [#text(fill:colors.red)[#sym.triangle.filled.small.r]]))
  set enum(numbering: n => text(fill:colors.red)[#n.])

  states.mlogo.update(logo)
  states.flogo.update(footer-logo)
  states.title.update(title)
  states.stitle.update(short-title)
  states.author.update(author)
  states.labo.update(laboratory)
  states.localization.update(localization)

  body
}