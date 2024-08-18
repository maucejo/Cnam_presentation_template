#import "@preview/polylux:0.3.1": *
#import "@preview/showybox:2.0.1": *
#import "@preview/codelst:2.0.1": sourcecode

//--------------------------- Configuration -----------------------------

// General parameters
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
  mlogo: state("mlogo", []),                 // Main logo
  flogo: state("flogo", []),                // Footer logo
  stitle: state("stitle", []),              // Short title
  plang: state("lang", "fr"),               // Language
  sec-count: counter("sec-count"),          // Section counter
  app-count: counter("app-count"),          // Appendix counter
)
//-----------------------------------------------------------------------

//--------------------------- Mathematics -------------------------------
// Space for equations
#let hs = sym.space.thin

// Emphasized box (for equations)
#let boxeq(body) = {
  set align(center)
  box(
    stroke: 1pt + colors.gray.lighten(20%),
    radius: 5pt,
    inset: 0.5em,
    fill: colors.gray.lighten(80%),
  )[#body]
}
//-----------------------------------------------------------------------

//------------------------ Utilities for boxes --------------------------
#let box-title(a, b) = {
  grid(columns: 2, column-gutter: 0.5em, align: (horizon),
    a,
    b
  )
}

#let colorize(svg, color) = {
  let blk = black.to-hex();
  if svg.contains(blk) {
    svg.replace(blk, color.to-hex())
  } else {
    svg.replace("<svg ", "<svg fill=\""+color.to-hex()+"\" ")
  }
}

#let color-svg(
  path,
  color,
  ..args,
) = {
  let data = colorize(read(path), color)
  return image.decode(data, ..args)
}
//-----------------------------------------------------------------------

//--------------------------- Utility boxes -----------------------------
// Information box
#let info(body) = {
  set text(size: config.box-text-size)
  let btitle = {
    context{
      let lang = states.plang.at(here())
      if lang == "fr" {
        strong("Remarque")
      } else {
        strong("Note")
      }
    }
  }

  showybox(
    title: box-title(color-svg("assets/icons/info.svg", colors.red, width: 1em), [#btitle]),
    title-style: (
      color: colors.red,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.red.lighten(80%),
      border-color: colors.red,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Tip box
#let tip(body) = {
  set text(size: config.box-text-size)
  let btitle = {
    context{
      let lang = states.plang.at(here())
      if lang == "fr" {
        strong("Astuce")
      } else {
        strong("Tip")
      }
    }
  }

  showybox(
    title: box-title(color-svg("assets/icons/light-bulb.svg", colors.green, width: 1em), [#btitle]),
    title-style: (
      color: colors.green,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.green.lighten(80%),
      border-color: colors.green,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Important box
#let important(body) = {
  set text(size: config.box-text-size)
  showybox(
    title: box-title(color-svg("assets/icons/report.svg", colors.blue, width: 1em), [*Important*]),
    title-style: (
      color: colors.blue,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.blue.lighten(80%),
      border-color: colors.blue,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Question box
#let question(body, type: none) = {
  set text(size: config.box-text-size)
  showybox(
    title: box-title(color-svg("assets/icons/question.svg", colors.purple, width: 1em), [*Question*]),
    title-style: (
      color: colors.purple,
      sep-thickness: 0pt,
    ),
    frame: (
      title-color: colors.purple.lighten(80%),
      border-color: colors.purple,
      body-color: none,
      thickness: (left: 3pt),
      radius: (top-left: 0pt, bottom-right: 1em, top-right: 1em),
    )
  )[#body]
}

// Code box
#let code(lang: none, body) = sourcecode(
    frame: showybox.with(
      title: [*Code* #h(1fr) #strong(lang)],
      frame: (
        title-color: colors.red,
        border-color: colors.red,
        body-color: none,
        thickness: (left: 3pt),
        radius: (top-left: 0pt, top-right: 1em),
      )
    ),
    body
)

// Link box
#let link-box(location, name) = {
  set align(bottom + left)
  block(fill: colors.red, radius: 1em, inset: 0.5em)[
    #set text(fill: white, size: 0.8em, weight: "bold")
    #link(location, name)
  ]
}
//-----------------------------------------------------------------------

//--------------------------- Progress bar ------------------------------
#let cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let slide-progress-bar = utils.polylux-progress( ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    cell(fill: colors.red),
    cell(fill: colors.gray.lighten(40%))
  )
})

#let section-progress-bar = {
  context{
    let ratio = states.sec-count.at(here()).first()/states.sec-count.final().first()
    grid(
      columns: (ratio*100%, 1fr),
      cell(fill: colors.red),
      cell(fill: colors.gray.lighten(40%))
    )
  }
}

#let appendix-progress-bar = {
  context{
    let ratio = states.app-count.at(here()).first()/states.app-count.final().first()
    grid(
      columns: (ratio*100%, 1fr),
      cell(fill: colors.red),
      cell(fill: colors.gray.lighten(40%))
    )
  }
}

#let presentation-progress-bar = {
  context{
    let ratio = states.sec-count.at(here()).first()/states.sec-count.final().first()
    grid(
      columns: (ratio*100%, 1fr),
      cell(fill: colors.red),
      cell(fill: colors.gray.lighten(40%))
    )
  }
}
//-----------------------------------------------------------------------

//------------------------- Theme definition ----------------------------
#let pres-template(
  aspect-ratio: "16-9",
  lang: "fr",
  logo: "assets/logo_cnam_lmssc.png",
  footer-logo: "assets/lecnam.png",
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

  show math.equation: set text(font: math-font, weight: config.weight, stylistic-set: 1)
  set list(marker: ([#text(fill:colors.red)[#sym.bullet]], [#text(fill:colors.red)[#sym.triangle.filled.small.r]]))
  set enum(numbering: n => text(fill:colors.red)[#n.])

  states.mlogo.update(logo)
  states.flogo.update(footer-logo)
  states.plang.update(lang)

  body
}

// Title slide
#let title-slide(
  author: [Votre nom],
  laboratory: [Laboratoire de recherche],
  title: [Titre de la présentation],
  short-title: [Titre court]
) = {
  let content = {
    set text(config.text-size)
    set align(center + horizon)

    block(width: 100%, inset: 2cm,
    {
      context{
        let logo = states.mlogo.at(here())
        if type(logo) == type("string") {
          set align(top + right)
          v(-2.5em)
          image(logo, height: config.logo-height)
        } else if logo == none {
          v(2em)
        } else {
          v(-2.5em)
          grid(
            columns: logo.len(),
            column-gutter: 1fr,
            ..logo.map((logos) => (align(center + horizon, image(logos, height: config.logo-height))))
          )
        }
      }

      v(1em)
      line(length: 100%, stroke: 0.15em + colors.red)
      text(size: 1.75em, strong(title, delta: 300))
      line(length: 100%, stroke: 0.15em + colors.red)

      v(0.5em)
      if author != none {
        set text(size: 1em)
        block(spacing: 1em, strong(author, delta: 250))
      }
      if laboratory != none {
        set text(size: 0.85em)
        block(spacing: 1em, laboratory)
        v(1em)
      }
    })
  }
  logic.polylux-slide(content)
  states.stitle.update(short-title)
  logic.logical-slide.update(i => i - 1)
}

// Normal slide
#let slide(title: none, subtitle: none, body) = {
  let header = {
    set align(top)
    if title != none {
      show: cell.with(fill: colors.red, inset: 1em)
      set align(horizon)
      set text(fill: white, size: 1.25em)
      strong(delta: 225, title)
      h(1fr)
      text(size: 0.75em, strong(utils.current-section, delta: 205))
    } else { [] }
  }

  let slide-counter = {
    pad(right: 2.5em, bottom: 2.25em, top: 0.25em,
    box(stroke: 1.75pt + colors.red, radius: 5pt, inset: -0.5em,outset: 1.6em)[#align(horizon)[#text(fill: colors.red, strong([#logic.logical-slide.display() / #utils.last-slide-number]))]]
    )
  }

  let footer = {
    set text(size: 0.8em)
    context{
      let logo = states.flogo.at(here())
      let title = states.stitle.at(here())
      v(-1.55em)
      pad(left: 1em, image(logo, height: 200%))

      if title != none {
        set align(horizon + center)
        v(-2.35em)
        text(fill: colors.red, strong(title, delta: 155))
      }
    }

    set align(bottom + right)
    slide-counter

    place(bottom, block(height: 2pt, width: 100%, spacing: 0pt, slide-progress-bar))
  }

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 1em),
  )

  let content = {
    if subtitle != none {
      pad(left: 1em, bottom: -2.75em, text(fill: colors.red, size: 1.2em, strong(subtitle))
      )
    } else { v(-2.6em) }

    set align(horizon)
    show: pad.with(2em)
    body
  }

  logic.polylux-slide(content)
}

// Content slide - Uncounted slide
#let content-slide() = {
  let header = {
    set align(top)
    show: cell.with(fill: colors.red, inset: 1em)
    set align(horizon)
    set text(fill: white, size: 1.2em)
    set strong(delta: 300)
    context{
      let lang = states.plang.at(here())
      if lang == "fr" {
        strong("Sommaire")
      } else {
        strong("Outline")
      }
    }
  }

  set page(
    header: header,
    margin: (top: 3em, bottom: 1em),
  )

  set align(horizon)
  set enum(spacing: 2em)
  show: pad.with(2em)
  text(size: 1.2em, strong(utils.polylux-outline(enum-args: (tight: false, )), delta: 200))
}

// New section slide - Uncounted slide
#let new-section-slide(name) = {
  states.sec-count.step()
  let content = {
    utils.register-section(name)
    set align(horizon)
    show: pad.with(10%)
    set text(size: 1.5em)
    strong(name)
    v(-0.75em)
    block(height: 2pt, width: 100%, spacing: 0pt, section-progress-bar)
  }

  logic.polylux-slide(content)
  logic.logical-slide.update(i => i - 1)
}

// Focus slide - Uncounted slide
#let focus-slide(body) = {
  set page(fill:colors.red, margin: 2em)
  set strong(delta: 155)
  set text(fill: white, size: 2em)
  logic.polylux-slide(align(horizon + center, strong(body)))
  logic.logical-slide.update(i => i - 1)
}

// Appendix slide - Uncounted slide
#let appendix-slide(subtitle: none, body) = {
  let header = {
    set align(top)
    show: cell.with(fill: colors.red, inset: 1em)
    set align(horizon)
    set text(fill: white, size: 1.2em)
    context{
      let lang = states.plang.at(here())
      if lang == "fr" {
        strong("Annexes")
      } else {
        strong("Appendices")
      }
    }
  }

  let slide-counter = context{
    pad(right: 2.5em, bottom: 2.25em, top: 0.25em,
      box(stroke: 1.75pt + colors.red, radius: 5pt, inset: -0.5em,outset: 1.6em)[
        #align(horizon)[#text(fill: colors.red, strong([A | #states.app-count.at(here()).first() / #states.app-count.final().first()]))]
      ]
    )
  }

  let footer = {
    set text(size: 0.8em)
    context{
      let logo = states.flogo.at(here())
      let title = states.stitle.at(here())
      v(-1.55em)
      pad(left: 1em, image(logo, height: 200%))

      if title != none {
        set align(bottom + center)
        v(-2.35em)
        text(fill: colors.red, strong(title))
      }
    }

    set align(bottom + right)
    slide-counter

    place(bottom, block(height: 2pt, width: 100%, spacing: 0pt, appendix-progress-bar))
  }

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 1em),
  )

  let content = {
    pad(left: 1em, bottom: -3em, text(fill: colors.red, size: 1.2em, strong(subtitle)))

    show: align.with(horizon)
    show: pad.with(2em)
    body
  }

  logic.polylux-slide(content)
  logic.logical-slide.update(i => i - 1)
  states.app-count.step()
}
//-----------------------------------------------------------------------