#import "@preview/ctheorems:1.1.2": *

#let theorem = thmbox(
  "theorem",
  "Theorem",
  supplement: "Thm.",
  inset: 0pt,
  titlefmt: title => [#smallcaps(title)],
  bodyfmt: body => [_ #body _],
)

#let definition = thmbox(
  "definition",
  "Definition",
  supplement: "Def.",
  inset: 0pt,
  titlefmt: title => [#smallcaps(title)],
  bodyfmt: body => [#body],
)

#let lemma = thmbox(
  "lemma",
  "Lemma",
  supplement: "Lem.",
  inset: 0pt,
  titlefmt: title => [#smallcaps(title)],
  bodyfmt: body => [_ #body _],
)

#let proof(body) = block[
  _Proof._ #body #h(2em) #sym.rect.v
]

// Reference figures with just "Fig."...
#set figure(numbering: "1", supplement: "Fig.")
// ...but display the full word "Figure" in the figure caption
//    (`Figure` instead of `#it.supplement` below)
#show figure.caption : it => [Figure #it.counter.display(it.numbering)#it.separator#it.body]

#import "@preview/lovelace:0.3.0": *

// Thanks @Julian-Wassmann https://github.com/typst/typst/discussions/2280#discussioncomment-7612699
// Use (2.3) for the global 3rd algorithm, in the 2nd section
#let customAlgoNumbering(n, loc) = {
  let level1HeadingNumber = counter(heading).at(loc).at(0)
  let headingNumbering = numbering("1", level1HeadingNumber)
  let algorithmNumbering = numbering("1", n)
  text(weight: "thin")[#headingNumbering.#algorithmNumbering] // "thin" seems to cancel out a hard-coded bold formatting somewhere...
}

#let ALGO_SUPPLEMENT = smallcaps(text(weight: "thin")[Algorithm]) // "thin" seems to cancel out a hard-coded bold formatting somewhere...

// outside conf() to be imported in main.typ
#let algorithm(body) = figure(
  kind: "algorithm",
  supplement: ALGO_SUPPLEMENT, 
  numbering: n => locate(loc => {
    customAlgoNumbering(n, loc)
  }),
  box[
    #body
  ]
)

#let conf(
  title: none,
  authors: none,
  abstract: none,
  doc
) = {

  set page(
    paper: "us-letter",
    margin: 0.85in,
    footer: align(
      right + top,
      text(size: 7pt)[ // https://www.sascha-frank.com/latex-font-size.html for `\scriptsize` & the `article` documentclass
        Copyright © 2025 by SIAM\
        Unauthorized reproduction of this article is prohibited
      ]
    )
  )

  set par(justify: true) // sadly, `par` does not have a `all-but-first-line-indent` parameter

  set text(
    font: "New Computer Modern",
    size: 9pt,
  )

  set footnote(numbering: "*")
  set footnote.entry(
    separator: line(length: 3em, stroke: 0.5pt)
  )

  align(center)[

    #v(0.7in) // increase top margin on the first page

    #text(
      size: 14pt, // https://www.sascha-frank.com/latex-font-size.html for `\Large` & the `article` documentclass
      title
    )

    #text(
      size: 11pt,
    )[
      #if type(authors) == str or type(authors) == content {
        authors
      } else if type(authors) == array {
        // from https://typst.app/docs/tutorial/making-a-template/
        let count = authors.len()
        let ncols = calc.min(count, 3)
        grid(
          columns: ncols,
          column-gutter: 50pt,
          row-gutter: 24pt,
          ..authors.map(author => [
            #author.name#footnote(author.affiliation)
          ]),
        )
      } else {
        panic(str(type(authors)) + " is not a valid type for authors")
      }
    ]

    #v(1em)
  ]

  set footnote(numbering: "1")

  set heading(numbering: "1.1")

  let SPACE_BETWEEN_HEADING_AND_ITS_NUMBER = 0.7em

  show heading.where(level: 1): header => {
    set text(size: 9pt, weight: "bold")
    block(breakable: false)[
      // No number in front of "References"
      // thanks @laurmaedje https://github.com/typst/typst/discussions/1055#discussioncomment-5770540
      #if header.numbering != none [ #counter(heading).display() #h(SPACE_BETWEEN_HEADING_AND_ITS_NUMBER) ]
      #header.body
      #v(0.5em)
    ]
  }

  show heading.where(level: 2): header => {
    set text(size: 9pt, weight: "bold")
    let number = context counter(heading).display()
    box[
      #number
      #h(SPACE_BETWEEN_HEADING_AND_ITS_NUMBER)
      #header.body
    ] // a box and not a block, to be able to write text on the same line
  }

  show heading.where(level: 3): header => {
    set text(size: 9pt, weight: "bold")
    let number = context counter(heading).display()
    box[
      #number
      #h(SPACE_BETWEEN_HEADING_AND_ITS_NUMBER)
      #header.body
    ] // a box and not a block, to be able to write text on the same line
  }

  // Thanks @Julian-Wassmann https://github.com/typst/typst/discussions/2280#discussioncomment-7612699
  // Use (2.3) for the global 3rd equation, in the 2nd section
  let customEqNumbering(n, loc) = {
    let level1HeadingNumber = counter(heading).at(loc).at(0)
    let headingNumbering = numbering("1", level1HeadingNumber)
    let equationNumbering = numbering("1", n)
    [(#headingNumbering.#equationNumbering)]
  }

  set math.equation(
    numbering: n => locate(loc => {
      customEqNumbering(n, loc)
    }),
    supplement: "Eq.",
    number-align: left
  )

  show: thmrules

  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      // Override equation references.
      let loc = el.location()
      let n = counter(math.equation).at(loc).first()
      customEqNumbering(n, loc)
    }
    else if el != none and el.func() == figure {
      let fig = el.func()
      // strangely, fig.kind is auto, not "figure" or "algorithm"
      if el.supplement == ALGO_SUPPLEMENT {
        // Override algorithm references.
        let loc = el.location()
        let n = counter(figure.where(kind: algorithm)).at(loc).first()+1
        "Algorithm " + customAlgoNumbering(n, loc)
      }
      else {
        // Reference of other kinds of figures as usual.
        it
      }
    }
    else {
      // Other references as usual.
      it
    }
  }

  columns(
    2,
    gutter: 10pt
  )[
    #block(breakable: false)[
      #text(weight: "bold")[Abstract]
    ]

    #abstract

    #doc
  ]
  
}