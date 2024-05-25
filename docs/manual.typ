#import "../pres-template.typ": *
#import "./manual-template.typ": *

#show: manual-template.with(
	title: " Modèle de présentation Typst",
	subtitle: "Présentations de type Beamer en Typst",
	abstract : [Ce package Typst est une proposition de modèle de présentation de type Beamer en Typst pour les personnels du Laboratoire de Mécanique des Structures et des Systèmes Couplés du Conservatoire National des Arts et Métiers.]
)

= Introduction

Dans l'univers #typst, plusieurs package propose des modèles de présentation de type Beamer. Il en existe actuellement 3 que l'on trouver sur #link("https://typst.app/universe/", text("Typst Universe", fill: typst-color)) :

- Polylux -- #link("https://typst.app/universe/package/polylux", text("Typst: Universe", fill: typst-color)), #link("https://github.com/andreasKroepelin/polylux", text("dépôt Github", fill: typst-color)) et #link("https://polylux.dev/book/", text("documentation", fill: typst-color))

- Touying -- #link("https://typst.app/universe/package/touying", text("Typst: Universe", fill: typst-color)), #link("https://github.com/touying-typ/touying", text("dépôt Github", fill: typst-color)) et #link("https://touying-typ.github.io/touying/", text("documentation", fill: typst-color))

- Slydst -- #link("https://typst.app/universe/package/slydst", text("Typst: Universe", fill: typst-color)), #link("https://github.com/glambrechts/slydst", text("dépôt Github", fill: typst-color)) et documentation (voir le ReadMe)

Pour créer ce modèle de présentation, mon choix s'est porté sur Polylux, car je le trouve plus simple d'utilisation que Touying (syntaxe plus typique de Typst) et permettant une plus grande évolutivité que Slydst.

= Utilisation

Pour utiliser le modèle, il faut l'importer dans votre fichier principal `typ` en utilisant la commande suivante.

#codesnippet[
	```typ
	#import "./template/pres-template.typ": *
	```
]

== Initilisation du modèle

Après avoir importé le modèle, celui doit être initialisé en appliquant une règle d'affichage (`show` rule) avec la commande #cmd("pres-template") en passant les options nécessaires avec l'instruction `with` dans votre fichier principal `typ` :

#codesnippet(
	```typ
	#show pres-template.with(
	  ...
	)
	```
)

Le modèle #cmd("pres-template") possède un certain nombre de paramètres permettant de personnaliser le document. Voici la liste des paramètres disponibles :

#command("pres-template", ..args(
	aspect-ratio: "16-9",
  lang: "fr",
  logo: "../images/logo_cnam.png",
  footer-logo: "../images/logo_cnam.png",
  font: "Noto Sans",
  math-font: "Noto Sans Math",
	[body]))[
		#argument("aspect-ratio", default: "16-9", types: "string")[Rapport d'aspect de la présentation. Autre format disponible : `"4-3"`.]

		#argument("lang", default: "fr", types: "string")[Langue du document. En fonction de la valeur prise par ce paramètre, la localisation  du document sera adaptée.

		Outre le français, la seule langue prise en compte est l'anglais (`lang: "en"`).]

		#argument("logo", default: "../images/logo_cnam.png", types: ("string","array"))[Chemin vers les logos pour la dispositive de titre.
			#wbox[
				#set text(size: 11pt)

				Il faut que le template soit à la racine du répertoire pour que le chemin soit correctement interprété. Dans le cas contraire, une erreur de compilation sera générée.
			]

		Pour utiliser plusieurs logos, il faut créer une liste de liens vers les images. \ Exemple -- `logo: ("../images/logo1.png", "../images/logo1.png")`.
		]

		#argument("footer-logo", default: "../images/logo_cnam.png", types: "array")[Chemin vers le logo principal.]

		#argument("body-font", default: "Noto Sans", types: "string")[Nom de la police de caractère du corps du texte.]

		#argument("math-font", default: "Noto Sans Math", types: "string")[Nom de la police de caractère des équations mathématiques.]

		#ibox[
		#set text(size: 11pt)

		Les polices de caractère doivent être préalablement installées sur votre système pour être utilisées dans le document.

		Pour vérifier la disponibilité de la police choisie, vous pouvez entrer la commande `typst font` dans un terminal.
		]
	]

== Contenu de la présentation

D'une manière générale, le fichier contenant votre présentation est structuré de la manière suivante :
#codesnippet[
	```typ
	// Diapositive de titre
	#title-slide(...)

	// Sommaire
	#content-slide()

	// Diapositive de section
	#new-section-slide(...)

	// Diapositive
	#slide(...)[
		// Contenu de la diapositive
	]

	// Pour réveiller l'auditoire
	#focus-slide[
		// Contenu de la diapositive
	]

	// Annexes
	#appendix-slide[
		// Contenu de la diapositive
	]
	```
]

Le contenu de la présentation est structuré grâce à six types de diapositves, dont les spécificités sont décritres dans les sections qui suivent.

=== Diapostive de titre

La diapsitive de titre est définie par la foction #cmd("title-slide") qui dispose d'un certain nombre de paramètres permettant de personnaliser la diapositive. Voici la liste des paramètres disponibles :

#command("title-slide", ..args(
	author: "Votre nom",
  laboratory: "Laboratoire de recherche",
	title: "Titre de la présentation",
	short-title: "Titre court",
	[body]))[
		#argument("author", types: ("string", "content"))[Auteurs de la présentation.

		#example-box[
			```typ
			#let author = [#text(fill: colors.red, [Author 1]) #h(1em) Author 2]
			```
		]]

		#argument("laboratory", types: ("string", "content"))[Nom du laboratoire de recherche.

		#example-box[
				```typ
				#let laboratory = [Laboratoire de Mécanique des Structures et des Systèmes Couplés \
				Conservatoire National des Arts et Métiers
				]
				```
		]]

		#argument("title", types: ("string", "content"))[Titre de la présentation.

		#example-box[
			```typ
			#let title = [Titre \
				#line(length: 15%, stroke: 0.075em + red) \
				#text([Sous-titre], size: 0.8em)
			]
			```
		]]

		#argument("short-title", types: "string")[Titre court de la présentation.]
	]

#figure(
	image("manual-images/slide-title.png", width: 60%),
	caption: [Exemple de diapositive de titre]
)

=== Diapositive de sommaire

Pour créer une dipositive de sommaire, il faut insérer la commande #cmd("content-slide") dans votre fichier de présentation `typ`.

#figure(
	image("manual-images/sommaire.png", width: 60%),
	caption: [Exemple de diapositive de sommaire]
)

=== Diapositive de section

Pour créer une diapositive de section, il faut insérer la commande #cmd("new-section-slide") dans votre fichier de présentation `typ`. Cette commande prend en paramètre le titre de la section sous la forme d'un élément de type #dtype("string") ou #dtype("content").

#figure(
	image("manual-images/first-sec.png", width: 60%),
	caption: [Exemple de diapositive de section]
)

=== Diapositive de contenu

Les diapositives de contenu sont les diapositives classiques de votre présentation. Elles sont définies par la fonction #cmd("slide") qui dispose de deux paramètres `title` et `subtitle` permettant de personnaliser la diapositive. Pour appeler la fonction, il suffit d'insérer la commande :

#command("slide", ..args(
	title: none,
	subtiltle: none,
	[body]))[]

#figure(
	image("manual-images/contenu.png", width: 60%),
	caption: [Exemple de diapositive standard]
)

=== Diapositive d'annexe

Pour créer une diapositive d'annexe, il faut insérer la commande #cmd("appendix-slide") dans votre fichier de présentation `typ`.

#figure(
	image("manual-images/annexe.png", width: 60%),
	caption: [Exemple de diapositive d'annexe]
)

#ibox[Par défaut, les diapositives d'annexe ne sont pas numérotées]

=== Diapositive "focus"

Pour créer une diapositive pour attirer l'attention de votre auditoire, il faut insérer la commande #cmd("focus-slide") dans votre fichier de présentation `typ`.

#figure(
	image("manual-images/focus.png", width: 60%),
	caption: [Exemple de diapositive "focus"]
)

=== Fonctions complémentaires

Le modèle de présentation Typst propose plusieurs fonctions complémentaires permettant d'enrichir le contenu des diapositives. Voici la liste des fonctions disponibles :

- #cmd("boxeq") -- Cette fonction permet de créer une boîte autour d'une équation mathématique importante.

	#example-box[
		```typ
		#boxeq[$sum_(i=1)^n i = (n(n+1))/2$]
		```

		#align(center)[#line(stroke: 1pt + typst-color, length: 95%)]

		$
		#boxeq[$display(sum_(i=1)^n i = (n(n+1))/2)$]
		$
	]

- Boîtes permettant de mettre en avant des informations importantes dans votre présentation.

	- #cmd("info") -- Boîte d'information
	- #cmd("tip") -- Boîte de conseil
	- #cmd("important") -- Boîte pour les remarques importantes
	- #cmd("question") -- Boîte pour les questions

	#example-box[
		```typ
		#info[#lorem(10)]
		#tip[#lorem(10)]
		#important[#lorem(10)]
		#question[#lorem(10)]
		```

		#align(center)[#line(stroke: 1pt + typst-color, length: 95%)]

		#info[#lorem(10)]
		#tip[#lorem(10)]
		#important[#lorem(10)]
		#question[#lorem(10)]
	]

- #cmd("code") -- Cette fonction permet d'insérer un bloc de code dans votre présentation. Elle prend en paramètre le langage de programmation utilisé pour la coloration syntaxique.

	#example-box[
		````typ
		#code(lang:"Julia")[
		```julia
		# Un commentaire
		function squared(x)
		  return x^2
		end
		```
		]
		````

		#align(center)[#line(stroke: 1pt + typst-color, length: 95%)]

		#code(lang:"Julia")[
		```julia
		# Un commentaire
		function squared(x)
		  return x^2
		end
		```
		]
	]

- #cmd("link-box") -- Cette fonction permet de créer une boîte pour faire des liens entre les diapositives.

	#example-box[
		```typ
		#slide[
			#link-box(<slide2>, "Aller à la diapositive 2")
		] <slide1>

		#slide[
			#link-box(<slide1>, "Retour à la diapositive 1")
		] <slide2>
		```
	]


= Feuille de route

Le modèle est en cours de développement. Voici la liste des fonctionnalités qui sont implémentées ou le seront dans une prochaine version.

*Types de diapositives*

- [x] Diapositive de titre
- [x] Diapositive de sommaire
- [x] Diapositive de section
- [x] Diapositive de contenu
- [x] Diapositive d'annexe
- [x] Diapositive pour focaliser l'attention de l'auditoire

*Éléments de mise en page*

- [x] Personnalisation de l'en-tête des diapositives standard avec l'affichage du titre de la diapositive et du nom section courante
- [x] Personnalisation du pied de page (logo, titre court de la présentation, numérotation des diapositives)
- [ ] Numérotation des diapositives d'annexe en lettre + chiffres (A.1, par exemple) ?

*Éléments de contenu*

- [x] Création d'une boîte autour d'une équation mathématique via la fonction `boxeq`
- [x] Blocs de code avec coloration syntaxique via le package `codelst`
- [x] Boîtes permettant de mettre en avant certains contenus via le package `showybox`
- [x] Création de boîte pour faire des liens entre les diapositives

= Note de versions

- `polylux` -- version 0.3.1

- `codelst` -- version 2.0.1

- `showybox` -- version 2.0.1

