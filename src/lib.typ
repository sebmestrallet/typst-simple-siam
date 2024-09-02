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
      right + horizon,
      text(size: 7pt)[ // https://www.sascha-frank.com/latex-font-size.html for `\scriptsize` & the `article` documentclass
        Copyright © 2025 by SIAM\
        Unauthorized reproduction of this article is prohibited
      ]
    )
  )

  set par(justify: true)

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
      #if type(authors) == str {
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

  show heading.where(level: 1): header => {
    set text(size: 9pt, weight: "bold")
    let number = context counter(heading).display()
    block(breakable: false)[
      #number
      #h(1em)
      #header.body
      #v(0.5em)
    ]
  }

  show heading.where(level: 2): header => {
    set text(size: 9pt, weight: "bold")
    let number = context counter(heading).display()
    box[
      #number
      #h(1em)
      #header.body
    ] // a box and not a block, to be able to write text on the same line
  }

  // Thanks @Julian-Wassmann https://github.com/typst/typst/discussions/2280#discussioncomment-7612699
  // Use (2.3) for the 3rd equation of the 2nd section
  let customEqNumbering(n, loc) = {
    let level0HeadingNumber = counter(heading).at(loc).at(0)
    let headingNumbering = numbering("1", level0HeadingNumber)
    let equationNumbering = numbering("1", n)
    [(#headingNumbering.#equationNumbering)]
  }

  set math.equation(
    numbering: n => locate(loc => {
      customEqNumbering(n, loc)
    }),
    supplement: "Eq. ",
    number-align: left
  )

  columns(2)[
    #block(breakable: false)[
      #text(weight: "bold")[Abstract]
    ]

    #abstract

    #doc
  ]
  
}