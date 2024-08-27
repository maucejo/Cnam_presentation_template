#import "@preview/polylux:0.3.1": *
#import "_config.typ": *

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