#import "@preview/polylux:0.3.1": *
#import "_config.typ": *
#import "_progress-bars.typ": *

// Title slide
#let title-slide = {
  let content = context{
    set text(config.text-size)
    set align(center + horizon)

    let logo = states.mlogo.at(here())
    let title = states.title.at(here())
    let author = states.author.at(here())
    let labo = states.labo.at(here())

    block(width: 100%, inset: 2cm,
    {
      set image(height: config.logo-height)
      if type(logo) == "content" {
        set align(top + right)
        v(-2.5em)
        logo
      } else if logo == none {
        v(2em)
      } else {
        v(-2.5em)
        grid(
          columns: logo.len(),
          column-gutter: 1fr,
          ..logo.map((logos) => (align(center + horizon, logos)))
        )
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
      if labo != none {
        set text(size: 0.85em)
        block(spacing: 1em, labo)
        v(1em)
      }
    })
  }
  logic.polylux-slide(content)
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
      set image(height: 200%)
      pad(left: 1em, logo)

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
      let localization = states.localization.at(here())
      strong(localization.outline)
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
      let localization = states.localization.at(here())
      strong(localization.appendix)
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
      set image(height: 200%)
      pad(left: 1em, logo)

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