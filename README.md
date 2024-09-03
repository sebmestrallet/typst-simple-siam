# The `straightforward-siam` Typst package

A Typst template for SIAM paper submissions

## Template adaptation checklist

- [ ] Fill out `README.md`
  - Change the `my-package` package name, including code snippets
  - Check section contents and/or delete sections that don't apply
- [x] Check and/or replace `LICENSE` by something that suits your needs
- [x] Fill out `typst.toml`
  - See also the [typst/packages README](https://github.com/typst/packages/?tab=readme-ov-file#package-format)
- [ ] Adapt Repository URLs in `CHANGELOG.md`
  - Consider only committing that file with your first release, or removing the "Initial Release" part in the beginning
- [ ] Adapt or deactivate the release workflow in `.github/workflows/release.yml`
  - to deactivate it, delete that file or remove/comment out lines 2-4 (`on:` and following)
  - to use the workflow
    - [ ] check the values under `env:`, particularly `REGISTRY_REPO`
    - [ ] if you don't have one, [create a fine-grained personal access token](https://github.com/settings/tokens?type=beta) with [only Contents permission](https://stackoverflow.com/a/75116350/371191) for the `REGISTRY_REPO`
    - [ ] on this repo, create a secret `REGISTRY_TOKEN` (at `https://github.com/[user]/[repo]/settings/secrets/actions`) that contains the so created token

    if configured correctly, whenever you create a tag `v...`, your package will be pushed onto a branch on the `REGISTRY_REPO`, from which you can then create a pull request against [typst/packages](https://github.com/typst/packages/)
- [ ] remove/replace the example test case
- [ ] (add your actual code, docs and tests)
- [ ] remove this section from the README

## Getting Started

These instructions will get you a copy of the project up and running on the typst web app. Perhaps a short code example on importing the package and a very simple teaser usage.

```bash
typst init @preview/straightforward-siam
```

```typ
#import "@preview/straightforward-siam:0.1.0": conf

#show: doc => conf(
  title: [A Typst template for SIAM paper submissions],
  authors: [Sébastien Mestrallet],
  abstract: [See #link("https://github.com/sebmestrallet/typst-straightforward-siam")],
  doc,
)

= First section

#lorem(50)
```

### Installation

A step by step guide that will tell you how to get the development environment up and running. This should example how to clone the repo and where to (maybe a link to the typst documentation on it), along with any pre-requisite software and installation steps.

```
$ First step
$ Another step
$ Final step
```

## Usage

A more in-depth description of usage. Any template arguments? A complicated example that showcases most if not all of the functions the package provides? This is also an excellent place to signpost the manual.

```typ
#import "@preview/my-package:0.1.0": *

#let my-complicated-example = ...
```

## Files

- [`src/lib.typ`](src/lib.typ): provide the `conf(title,authors,abstract,doc)` function to format a paper
- [`src/main.typ`](src/main.typ): use `conf()` to reproduce the outputs of `ltexpprt_anonymous-submission.tex` & `ltexpprt_accepted-submission.tex` from the official template
- [`src/bib.yml`](src/bib.yml): 	transcoding of `ltexpprt_references.bib` from the official template to the [Hayagriva](https://github.com/typst/hayagriva/blob/main/docs/file-format.md) format
- [`src/siam.csl`](src/siam.csl): [Citation Style Language](https://citationstyles.org/) for the bibliography, based on the [IEEE](https://github.com/citation-style-language/styles/blob/master/ieee.csl) one (modified `<macro name="author">` to have small caps)

## Ressources

TeX sources of the official template:
- The [SIAM two-column template](https://internationalmeshingroundtable.com/assets/files/imr33/templates.zip) referenced for the [SIAM International Meshing Roundtable Workshop 2025](https://internationalmeshingroundtable.com/imr33/call-for-papers/#formatting-requirements)
- The [SIAM Macros](https://epubs.siam.org/journal-authors#macros) on the SIAM website
- The [2019 SIAM style manual](https://epubs.siam.org/pb-assets/files/SIAM_STYLE_GUIDE_2019.pdf) on the SIAM website

How to create and publish a Typst template package:
- The motivation and recommended interface for templates in the [official tutorial](https://typst.app/docs/tutorial/making-a-template/)
- The in-depth format requirements in the [typst/packages](https://github.com/typst/packages) README
- Do as the [templates directly maintained by the Typst team](https://github.com/typst/templates)
- Use the [typst-package-template](https://github.com/typst-community/typst-package-template) GitHub template from [@typst-community](https://github.com/typst-community)