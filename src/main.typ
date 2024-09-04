#import "lib.typ": conf, theorem, definition, lemma, thmrules, proof, pseudocode-list, algorithm
#show: thmrules // I don't know why, but if this line is in lib.typ, the thmboxes are center-aligned

#let ANONYMOUS = false

// IMPORTANT: Reproduction of the `\anon{anonymous}{known}` command
//   1. To ensure anonymity during the double-blind review, 
//   2. To easily switch to a non-anonymous version for publication.
// 
// With the anon function, first argument shows when anonymous and the second when non-anonymous (known).
// e.g. #anon("Me, Scott Mitchell, wrote this paper.","The author will remain anonymous during the double blind review.")
// e.g. Our code is available at #anon("http://github.com/myname/mycode", "anonymized for double blind review.")
//
// The author and acknowledgements section have already been wrapped in this macro for your convenience.
#let anon(anonymous,known) = {
  if ANONYMOUS {
    anonymous
  }
  else {
    known
  }
}

#show: doc => conf(
  title: [#anon("Anonymized","Known-authors") SIAM/ACM Preprint for Use With Typst#footnote([The full version of the paper can be accessed at #anon([`redacted-url`],link("https://arxiv.org/abs/1902.09310"))])],
  authors: anon(
    "Submission ID XYZ",
    (
      (
        name: "Corey Gray",
        affiliation: "Society for Industrial and Applied Mathematics."
      ),
      (
        name: "Tricia Manning",
        affiliation: "Society for Industrial and Applied Mathematics."
      )
    )
  ),
  abstract: "An abstract is a brief summary of the paper’s contributions, written for experts. " + anon("Authors are anonymized for double-blind review.","It was written by Gray and Manning."),
  doc,
)

= Introduction

An introduction is a gentler description and summary
of the paper than the abstract, written for non-experts.
It describes the paper’s concepts, contribution, context
and significance.

== Problem Specification.
In this paper, we consider the solution of the $N times N$ linear system

// numbered equation
$
A x = B
$ <eq:axb>

where $A$ is large, sparse, symmetric, and positive definite.
We consider the direct solution of @eq:axb by
means of general sparse Gaussian elimination. In such
a procedure, we find a permutation matrix $P$, and compute
the decomposition

// not-numbered equation
#align(center)[
  $P A P^t = L D L^t$
]

where $L$ is unit lower triangular and $D$ is diagonal.

= Design Considerations. <sec:design>

Several good ordering algorithms (nested dissection and
minimum degree)
are available for computing $P$~@bib:GEORGELIU @bib:ROSE72.
Since our interest here does not
focus directly on the ordering, we assume for convenience that $P=I$,
or that $A$ has been preordered to reflect an appropriate choice of $P$.

#h(1.5em)
Our purpose here is to examine the nonnumerical complexity of the
sparse elimination algorithm given in~@bib:BANKSMITH.
As was shown there, a general sparse elimination scheme based on the
bordering algorithm requires less storage for pointers and
row/column indices than more traditional implementations of general
sparse elimination.  This is accomplished by exploiting the m-tree,
a particular spanning tree for the graph of the filled-in matrix.

#theorem[
  The method was extended to three dimensions.
  For the standard multigrid coarsening (in
  which, for a given grid, the next coarser grid has $1 slash 8$ as
  many points), anisotropic problems require plane relaxation
  to obtain a good smoothing factor.
] <thm:extend3d>

#h(1.5em)
Our purpose here is to examine the nonnumerical complexity of the
sparse elimination algorithm given in~@bib:BANKSMITH.
As was shown there, a general sparse elimination scheme based on the
bordering algorithm requires less storage for pointers and
row/column indices than more traditional implementations of general
sparse elimination; see @thm:extend3d.
This is accomplished by exploiting the m-tree,
a particular spanning tree for the graph of the filled-in matrix.
Several good ordering algorithms (nested dissection and minimum degree)
are available for computing $P$~@bib:GEORGELIU @bib:ROSE72.
Since our interest here does not
focus directly on the ordering, we assume for convenience that $P=I$,
or that $A$ has been preordered to reflect an appropriate choice of $P$.

#proof[
  In this paper we consider two methods. The first method
  is basically the method considered with two differences:
  first, we perform plane relaxation by a two-dimensional
  multigrid method, and second, we use a slightly different
  choice of
  interpolation operator, which improves performance
  for nearly singular problems. In the second method coarsening
  is done by successively coarsening in each of the three
  independent variables and then ignoring the intermediate
  grids; this artifice simplifies coding considerably.
]

#h(1.5em)
Our purpose here is to examine the nonnumerical complexity of the
sparse elimination algorithm given in~@bib:BANKSMITH.
As was shown there, a general sparse elimination scheme based on the
bordering algorithm requires less storage for pointers and
row/column indices than more traditional implementations of general
sparse elimination.  This is accomplished by exploiting the m-tree,
a particular spanning tree for the graph of the filled-in matrix.

#definition[
  We describe the two methods in @sec:design. 
In @sec:robustness we discuss some remaining details.
]

#h(1.5em)
Our purpose here is to examine the nonnumerical complexity of the
sparse elimination algorithm given in @bib:BANKSMITH.
As was shown there, a general sparse elimination scheme based on the
bordering algorithm requires less storage for pointers and
row/column indices than more traditional implementations of general
sparse elimination.  This is accomplished by exploiting the m-tree,
a particular spanning tree for the graph of the filled-in matrix.
Several good ordering algorithms (nested dissection and minimum degree)
are available for computing $P$~@bib:GEORGELIU @bib:ROSE72.
Since our interest here does not
focus directly on the ordering, we assume for convenience that $P=I$,
or that $A$ has been preordered to reflect an appropriate choice of $P$.

#h(1.5em)
Our purpose here is to examine the nonnumerical complexity of the
sparse elimination algorithm given in~@bib:BANKSMITH.
As was shown there, a general sparse elimination scheme based on the
bordering algorithm requires less storage for pointers and
row/column indices than more traditional implementations of general
sparse elimination.

#lemma[
  We discuss first the choice for $I_(k-1)^k$
  which is a generalization. We assume that $G^(k-1)$ is
  obtained
  from $G^k$
  by standard coarsening; that is, if $G^k$ is a tensor product
  grid $G_x^k times G_y^k times G_z^k$,
  $G^(k-1)=G_x^(k-1) times G_y^(k-1) times G_z^(k-1)$,
  where $G_x^(k-1)$ is obtained by deleting every other grid
  point of $G_x^k$ and similarly for $G_y^k$ and $G_z^k$.
]

#h(1.5em)
To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.

#h(1.5em)
In @sec:design, we review the bordering algorithm, and introduce
the sorting and intersection problems that arise in the
sparse formulation of the algorithm.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.

#h(1.5em)
For the old approach, we show that the
complexity of the intersection problem is $O(n^3)$, the same
as the complexity of the numerical computations.  For the
new approach, the complexity of the second part is reduced to
$O(n^2 (log n)^2)$.

#h(1.5em)
To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.
This is accomplished by exploiting the m-tree,
a particular spanning tree for the graph of the filled-in matrix.
To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:EISENSTAT @bib:GEORGELIU @bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE76 @bib:SCHREIBER.

#place(
  top,
  float: true
)[
  #block(width: 100%)[
    #figure(
      v(14*12pt), // <=> 14pc, with 1pc=12pt
      caption: [
        This is a blank figure.
      ]
    ) <fig:blank>
  ]
]

#h(1.5em)
We show a blank figure in @fig:blank.

== Robustness. <sec:robustness>
We do not
attempt to present an overview
here, but rather attempt to focus on those results that
are relevant to our particular algorithm; see @fig:blank.
This section assumes prior knowledge of the role of graph theory
in sparse Gaussian elimination; surveys of this role are
available in~@bib:ROSE72 @bib:GEORGELIU. More general
discussions of elimination trees are given in~@bib:LAW @bib:LIU @bib:LIU2 @bib:SCHREIBER.
Thus, at the $k$th stage, the bordering algorithm consists of
solving the lower triangular system

$
 L_(k-1)v = c
$

and setting

// with Typst we cannot both
// - have a different number for two successive equations
// - align the equal sign of two successive equations https://typst.app/docs/reference/math/#alignment
$
ell &= D^(-1)_(k-1)v ,
$
$
delta &= alpha - ell^t v .
$

= Algorithm <sec:algorithm>

We provide some pseudocode in @alg:deterministicmps.

#algorithm(
  pseudocode-list(
    numbered-title: [#smallcaps[(Deterministic-MPS)] maximal
Poisson-disk sampling],
    stroke: none,
    booktabs: false,
    indentation: 2em
  )[
    - *Require:* Rectangular grid $cal(G)$ of whole grid squares
    - *Require:* Flag if domain is pediodic: `True` or `False`
    - *Ensure:* Maximal Poisson-disk sampling og rectangle
      + *function* #smallcaps[Deterministic-MPS($cal(G)$)]
        + \/\/ Initialize Grid $cal(G)$
        + *for* $g in cal(G)$ *do*
          + $g$.point = $(u,v)$ uniform random in square
          + $g$.time = $A e^(-A w)$, rand $w$, expovariate in area
          + $g$.scooped-square = square polygon $g$
        + *end for*
        + Global pre-pass heuristic
        + \/\/ Find locally-early squares
        + *for* $g in cal(G)$ and $h in "neighbors"(g)$ *do*
          + increment \#antecedents of $g$ or $h$ (later)
        + *end for*
        + *for* $g in cal(G)$ *do*
          + EarlySquares.add($g$ if no antecedents)
        + *end for*
        + \/\/ Accept samples and update
        + *reapeat*
          + $g$ = EarlySquares.pop() #h(1fr) #sym.triangle any order
          + accept $g$.point as Poisson-disk sample
          + *for* $h in "neighbors"(g)$ *do*
            + decrement $h$.antecedents
            + #h(1fr) #sym.triangle since $g$ no longer blocks $h$
            + \/\/ resample candidates in disk($g$.point)
            + *if* $h$.point #sym.in disk($g$.point) *then*
              + $h$.scooped-square #sym.minus= disk($g$.point)
              + *if* $h$.scooped-square is empty *then*
                + $h$.time = #sym.infinity
              + *else*
                + trim chocks of $h$.scooped-square
                + triangulate remaining polygon
                + $U in {"chocks","triangles"}$ by area
                + $h$.point $in U$ uniform by area
                + $h$.time += expovar(A($h$.scooped-square))
              + *end if*
              + *for* $s in "neighbors"(h)$ *do*
                + *if* $h$ is later than $s$, but was earlier *then*
                  + increment $h$.antecedents
  ]
) <alg:deterministicmps>

// manual break

#pseudocode-list(
  stroke: none,
  booktabs: false,
  indentation: 2em,
  line-numbering: x => x+37 // manual line number offset
)[ // manual indentation because we do not start at level 0
  + #h(2em*7)decrement $s$.antecedents
  + #h(2em*6)*if* $s$ has no antecedents *then*
  + #h(2em*7)EarlySquares.add($s$)
  + #h(2em*6)*end if* //6
  + #h(2em*5)*end if* // 5
  + #h(2em*4)*end for* // 4
  + #h(2em*3)*end if* // 3
  + #h(2em*3)*if* $h$ has no antecedents *then* // 3
  + #h(2em*4)EarlySquares.add($h$) // 4
  + #h(2em*3)*end if* // 3
  + #h(2em*2)*end for* //2
  + #h(2em*1)*until* EarlySquares == empty //1
  + *end function*
]

= Results <sec:results>

We do not
attempt to present an overview
here, but rather attempt to focus on those results that
are relevant to our particular algorithm, @alg:deterministicmps.

== Versatility. <sec:versatility> The special
structure of this problem allows us to make exact estimates of
the complexity.  For the old approach, we show that the
complexity of the intersection problem is $O(n^3)$, the same
as the complexity of the numerical computations~@bib:GEORGELIU @bib:ROSEWHITTEN. For the
new approach, the complexity of the second part is reduced to
$O(n^2 (log n)^2)$.

#h(1.5em)
To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER}.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase @bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.

#h(1.5em)
In @sec:design, we review the bordering algorithm, and introduce
the sorting and intersection problems that arise in the
sparse formulation of the algorithm.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.

#h(1.5em)
For the old approach, we show that the
complexity of the intersection problem is $O(n^3)$, the same
as the complexity of the numerical computations.  For the
new approach, the complexity of the second part is reduced to
$O(n^2 (log n)^2)$.

#h(1.5em)
To our knowledge, the m-tree previously has not been applied in this
fashion to the numerical factorization, but it has been used,
directly or indirectly, in several optimal order algorithms for
computing the fill-in during the symbolic factorization phase~@bib:LAW @bib:LIU @bib:LIU2 @bib:ROSE72 @bib:ROSE76 @bib:ROSEWHITTEN @bib:SCHREIBER.
In @sec:robustness, we analyze the complexity of the old and new
approaches to the intersection problem for the special case of
an $n times n$ grid ordered by nested dissection. The special
structure of this problem allows us to make exact estimates of
the complexity. 

#bibliography("bib.yml", title: "References", style: "siam.csl")
