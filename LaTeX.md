# JMU UUG LaTeX Tutorial

## Introduction

**BEFORE WE START**: Get an [Overleaf](https://www.overleaf.com) account.

Overview: The TeX [typesetting](https://en.wikipedia.org/wiki/Typesetting)
system originated with Don Knuth in 1970s, prompted by his work on "The Art of
Computer Programming." It first ran on a PDP-10 in 1978. TeX uses a versioning
system w/ increasing digits of π; lastest is 3.14159265. It was extended to
LaTeX by Leslie Lamport (@ SRI International) in 1980s, and is now a full
document preparation system. The latest version is LaTeX 2e. LaTeX is widely
used in CS, Math, Engineering, and other scientific fields.

Introduce concepts:

 * Compiled typesetting (composing documents like C/Java programs)
 * Document description language (markup, like HTML)
 * Philosophy of separate content and form/presentation (like CSS)

Note: LaTeX is pronounced "lah-tech" or "lay-tech", NOT "lay-techs"!

## Document organization

* First thing: `\documentclass{article|IEEEtran|proc|report|book|beamer}`
   * For smaller margins: `\usepackage[margin=1in]{geometry}`
   * For UTF-8 support: `\usepackage[utf8]{inputenc}`
* Document info: `\title`, `\author`, `\date`, `\maketitle`
* Page numbers: `\pagenumbering{roman}`, `\thispagestyle{empty|plain}`, `\pagestyle{empty|plain}`
* Organization: `\section`, `\subsection`, `\subsubsection`
   * Others: `\tableofcontents`, `\label`, `\ref`
   * Use asterisk to toggle numbering
* Comments w/ `%`

## Formatting

* Lists: `\begin{enumerate|itemize}`, `\item`
* Common font/color formatting
   * `\textbf`, `\textit`, `\texttt`, `\underline`, quotes, `--`, `---`
   * Shorter forms: `{\bf }`, `{\it }`, `{\tt }`
   * `\usepackage{xcolor}`, `\textcolor{color}{text}`
   * `\begin{tiny|small|large|huge}`
   * `\begin{verbatim}`, `\verb!`
   * International formatting: UTF-8 or `\’`, `\”`, `\~`, etc.
* Footnotes: `\footnote`
* Images: `\includegraphics{file.png}`
   * Requires `\usepackage{graphicx}`
   * Options: `[scale=0.5]`, `[width=1in]`, `\begin{center}`
* Floating figures: `\figure`
   * Options: `\caption`, `\label` (needs to go at the end)
   * Works for verbatims or graphics, too
* Tables: `\tabular`, `\hline`, `[l|c|r]`, `\multicolumn{n}{cols}{text}`

## Mathematics

* Math mode: `\begin{equation}`, `$`, `$$`
* Sub/superscript, common operators (`\cdot`, `\leq`, `\approx`, `\times`, `\pm`)
* Greek letters (e.g., `\omega`, `\Omega`)
* Common functions: `\log`, `\sin`, `\cos`, `\tan`, `\min`, `\max`
* More complex operators: `\frac{}{}`, `\sqrt[]{}`, `\sum`, `\prod`, `\int`
* Delimiters:` \left([{<`, `\lfloor`, `\lceil`
* Logic symbols: `\in`, `\subset`, `\forall`, `\exists`, `\rightarrow`
* Spacing:  `\;`  `\:`  `\,`  `\!`
* Fun: `\flat`, `\sharp`, `\clubsuit`, `\heartsuit`, `\pitchfork`

## Bibliography

* Special BibTeX file format (`.bib`)
* Download references from [ACM Digital Library](https://dl.acm.org) and/or [IEEE Xplore](http://ieeexplore.ieee.org)
* `\bibliographystyle{plain}`, `\bibliography{fname}`
* `\cite{key}`

## Large documents

* Custom `.sty` files and Overleaf templates
* Multiple files: `\include`
* Importance of unique labels & bibliography management
* Build frameworks (e.g., Makefiles) -- need to rebuild multiple times!
* Latexmk and preview apps

## Macros

* Declaration: `\def\name{texthere}`
* Examples:
   * `\def\topK{\textsf{\textbf{topK}}}`
   * `\def\red#1{\textcolor{red}{#1}}`

Fun fact: LaTeX is Turing-complete!

## Useful Extensions

* AMS (American Mathematical Society) packages ([docs](http://mirrors.ctan.org/macros/latex/required/amsmath/amsmath.pdf))
   * `\usepackage{amsmath, amssym}`
   * `\begin{align*}`, `\noindent`
   * Theorems, lemmas, etc. ([Overleaf guide](https://www.overleaf.com/learn/latex/Theorems_and_proofs))
* Code listings ([docs](http://mirrors.ctan.org/macros/latex/contrib/listings/listings.pdf))
   * `\usepackage{listings}`
   * `\lstset{language=C|C++|Java|Python|LaTeX}` (or leave out for pseudocode)
   * `\begin{lstlisting}`
* Algorithm packages
   * [Overleaf guide](https://www.overleaf.com/learn/latex/algorithms)
   * [Wikibooks guide](https://en.wikibooks.org/wiki/LaTeX/Algorithms)
   * `\usepackage{algorithmicx,algpseudocode}`
   * `\begin{algorithmic}`
   * `\State` w/ math mode (`\gets` for assignment)
   * `\If{cond}`, `\Else`, `\ElsIf`, `\EndIf`
   * `\For{cond}`, `\ForAll{cond}`, `\EndFor`
   * `\While{cond}`, `\EndWhile`
   * `\Function{name}{params}`, `\EndFunction`, `\Return`, `\Call`
* Semantics/proof rules ([docs](http://mirrors.ctan.org/macros/latex/contrib/semantic/semantic.pdf))
   * `\usepackage{semantic}`
   * `\inference[name]{premise(s)}{conclusion}`
   * `->`, `=>`, `|-`
   * Recursive nesting for proof trees
* Beamer ([docs](http://mirrors.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf))
   * `\documentclass{beamer}`
   * `\begin{frame}`
   * `\frametitle`
   * Sections (same as usual, now with visual indicators)

## Common headaches

* Careful with underscores and other symbols
   * E.g.: `$` and `#` must be escaped
* Spacing: `\hspace`, `\vspace`, `\newpage`
   * Units: `in`, `cm`, `pt`
* Table positioning: `[t|h|b|p]`
* Finding typos and syntax errors
   * Q&A and experimentation
   * [TeX StackExchange](http://tex.stackexchange.com)

## Local installation

* Windows - use [MiKTeX](https://miktex.org)
* Mac OS X - use [MacTeX](http://www.tug.org/mactex/)
* Linux Mint - `sudo apt install texlive-latex-base`
* IDEs: [LyX](https://www.lyx.org), [TeXnicCenter](http://www.texniccenter.org), [TeXShop](http://pages.uoregon.edu/koch/texshop/)
* Plugins: [AUCTeX](https://www.gnu.org/software/auctex/) (Emacs), [TeXlipse](http://texlipse.sourceforge.net) (Eclipse), [Vim-LaTeX](http://vim-latex.sourceforge.net) (Vim)

## References

* [Overleaf tutorial](https://www.overleaf.com/tutorial)
* [LaTeX Wikibook](https://en.wikibooks.org/wiki/LaTeX)
* [TEXbook](http://www.ctex.org/documents/shredder/src/texbook.pdf)
* Quick-reference cards:
   * [General LaTeX](http://wch.github.io/latexsheet/)
   * [AMS LaTeX](http://www.math.brown.edu/~jhs/ReferenceCards/LaTeXRefCard.v2.0.pdf)
   * [Symbols](http://webdocs.cs.ualberta.ca/~c603/latex/LaTeX_docs/Symbol_Source/latex_symbols.pdf)

## Diversions

* [Computer Modern Unicode](http://cm-unicode.sourceforge.net/download.html) font (choose otf)
* [Lilypond](http://www.lilypond.org/) - LaTeX-like language for musical notation
* [LaTeX math jokes](http://tex.stackexchange.com/questions/18326/latex-math-jokes)
* [Coffee stains and the Simpsons](http://divisbyzero.com/2010/07/13/coffee-stains-and-the-simpsons-in-your-latex-document/)

