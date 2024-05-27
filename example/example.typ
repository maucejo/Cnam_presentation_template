#import "pres-template.typ": *

// Titre - Facultatif - Peut être écrit directement dans le #title-slide
#let title = [Filtres Bayésiens parcimonieux
#v(-0.5em)
#line(length: 15%, stroke: 0.075em + colors.red)
#v(-0.5em)
#text(size: 0.8em, [Application à l'identification d'effort])
]

// Laboratoire - Facultatif - Peut être écrit directement dans le #title-slide
#let labo = [Laboratoire de Mécanique des Structures et des Systèmes Couplés
#v(-0.5em)
Conservatoire National des Arts et Métiers
]

// Auteur - Facultatif - Peut être écrit directement dans le #title-slide
#let auteur = [#text(fill: colors.red, [Mathieu Aucejo]) #h(1em) Olivier De Smet]

// Appel du thème
#show: pres-template.with(
  // aspect-ratio: "4-3",
  // font: "New Computer Modern Sans",
  // math-font: "New Computer Modern Math",
  lang: "fr",
)

// Slide de titre
#title-slide(
  author: auteur,
  title: title,
  short-title: "Filtres Bayésiens parcimonieux",
  laboratory: labo,
)

// #title-slide()

// Slide pour le plan
#content-slide()

// Slide pour définir une nouvelle section
#new-section-slide([First section])

#slide(title: [Titre de la diapositive], subtitle: "Un sous-titre")[
  #boxeq[
  $
  bold(z)_(k + 1) = bold(A) hs bold(z)_k + bold(B) hs bold(u)_k + bold(w)_k \
  bold(y)_k = bold(C) hs bold(z)_k + bold(v)_k
  $
  ]

  - #lorem(20)

  #link-box(<code-slide>, "Aller à la diapositive de code")
] <first-slide>

#slide(title: [Titre])[]

#new-section-slide("Second section")

#slide(title: "Titre de la diapositive")[
  #info[#lorem(10)]
  #tip[#lorem(10)]
  #important[#lorem(10)]
  #question[#lorem(10)]
]

#new-section-slide("Third section")

#slide(title: "Titre de la diapositive")[
Un petit bout de code

#code(lang:"Julia")[
```julia
# Un commentaire
function squared(x)
  return x^2
end
```
]

#link-box(<first-slide>, "Retour à la première diapositive")
] <code-slide>

#slide(title: [Titre])[]
#slide(title: [Titre])[]

// Slide pour réveiller l'assistance
#focus-slide[
  Merci de votre attention

  Questions ?
]

#appendix-slide[
  Une annexe
]

#appendix-slide[
  Une annexe
]