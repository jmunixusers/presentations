---
marp: true
class: invert
---
<!--
Presenter notes
Slides:
 	1.Define the terms (
 		roff,
 		troff,
 		groff,
		)
	2. What is roff (history lesson, a runoff language for making documents (what you see is what you get vs what you see is what you mean WYSIWYG vs WYSIWYM)
	3. How to use roff (install instructions for mac)
	4. Groff macro sets
	5. Make a simple groff ms text file in groff_ms (.TL, .AU, .AI, .PP, etc)
	6. Compiling groff (device files, grog, how it works under the hood (pipelining)
	7. Extra programs (eqn)
	8. Customizing groff with source files (format.ms)
	9. modifying vim to compile groff automatically (use the code already below)
	10. Extra resources (luke smith, man pages, mr beatty email!)
	11. Live demo (proguide.ms) (add chem)
-->

# The Roff Document Formatting System

Mitch Feigenbaum - <https://mrf-dot.github.io>

---

## Define the Terms

- `roff` Document runoff program
- `troff` Typesetting roff
- `groff` (g/Troff) GNU troff

---

## What is Roff?

- Document preparation using computers dates back to the 1960s
- Roff is based on the original Runoff language, which predates UNIX
- Roff is what you see is what you mean (WYSIWYM), not what you see is what you get (WYSIWYG)

---

## What you need

1. Valid Groff Installation
	- Linux: It's already installed
	- Mac: `brew install groff`
2. Text Editor (VIM recommended)

---

## Macro Sets

- MAN (manual)
- MOM (my own macros)
- MS (used in this presentation)
- ME
- MM

---

## MAN Macro Set Quick Reference

```
       Macro   Meaning                         Subsection
       ───────────────────────────────────────────────────────────────────
       .B      Bold                            Font style macros
       .BI     Bold, italic alternating        Font style macros
       .BR     Bold, roman alternating         Font style macros
       .EE     Example end                     Document structure macros
       .EX     Example begin                   Document structure macros
       .I      Italic                          Font style macros
       .IB     Italic, bold alternating        Font style macros
       .IP     Indented paragraph              Paragraph macros
       .IR     Italic, roman alternating       Font style macros
       .LP     (Left) paragraph                Paragraph macros
       .ME     Mail-to end                     Hyperlink and email macros
       .MT     Mail-to start                   Hyperlink and email macros
       .OP     (Command-line) option           Command synopsis macros
       .P      Paragraph                       Paragraph macros
       .PP     Paragraph                       Paragraph macros
       .RB     Roman, bold alternating         Font style macros
       .RE     Relative-indent end             Document structure macros
       .RI     Roman, italic alternating       Font style macros
       .RS     Relative-indent start           Document structure macros
       .SB     Small bold                      Font style macros
       .SH     Section heading                 Document structure macros
       .SM     Small                           Font style macros
       .SS     Subection heading               Document structure macros
       .SY     Synopsis start                  Command synopsis macros
       .TH     Title heading                   Document structure macros
       .TP     Tagged paragraph                Paragraph macros
       .TQ     Tagged paragraph continuation   Paragraph macros
       .UE     URL end                         Hyperlink and email macros
       .UR     URL start                       Hyperlink and email macros
       .YS     Synopsis end                    Command synopsis macros
```

---

## Using Groff MS

- Macros begin on a new line with a period

```roff
.TL
```

- The content (text) corresponding to the macro is on the following line

```roff
.TL
title
```

- Some macros take arguments, such as the `.IP` macro

```roff
.IP \(bu
```

---

## Groff MS Macros

1. Report Cover
2. Document Content
3. Text Styling
4. Document Preprocessors

---

## Report Cover Macros

- `.RP [no]` (Report Cover) [no indicates header on second page]
- `.TL` (Title)
- `.AU` (Author)
- `.AI` (Institution)
- `.AB [no]` (Abstract Start) [no indicates **ABSTRACT** not printed]
- `.AE` (Abstract End)

---

## Headings

- `.NH [number]` (Numbered Header) [number indicates level]

```groff
.NH 1
Top Level
.NH 2
Second level
.NH 3
Third level
```

- `.SH` (Section Header)

---

## Paragraphs

- `.PP` (Paragraph)
- `.LP` (Paragraph without initial indent)
- `.XP` (Paragraph with hanging indent)
- `.QP` (Quoted Paragraph)

### Quoted Paragraphs

- `.QS`
- `.QE`
- `.QS` and `.QE` can contain `.LP` and `.PP` macros

---

## Lists

- `.IP [marker [width]]`

### Unordered (bulleted) list

```groff
.IP \(bu
Apple
.IP \(bu
Banana
```

### Ordered (numbered) list
```groff
.nr a 0
.IP \n+a
Apple
.IP \n+a
Banana
```

---

## Indents

- `.RS` (Start Indented Block)
- `.RE` (End Indented Block)
- Nested indents are possible (useful for creating nested lists)

```roff
.IP 1
Point 1
.RS
.	IP 1.1
Nested point 1.1
.	RS
.		IP 1.1.1
Nested point 1.1.1
.	RE
.RE
```

---

## Displays and Keeps

- Displays will allow you to write prose (such as lines of code)
- Keeps will try to keep the content within the blocks on the same page

| With keep        | No keep  | Type of Display |
| --------         | -------- | --------        |
| `.DS L`          | `.LD`    | Left-justified  |
| `.DS I [indent]` | `.ID`    | Indented        |
| `.DS B`          | `.BD`    | Block-centered  |
| `.DS C`          | `.CD`    | Centered        |
| `.DS R`          | `.RD`    | Right-justified |
---

## Displays and Keeps (cont.)

- `.DE` ends any display (keep or no keep)
- Text between `.KS` and `.KE` keeps text together on the page
- Text between `.KF` and `.KE` will make a floating keep (when you care that text be grouped together but don't care where)
- Text between `.B1` and `.B2` will be boxed

---

## Footnotes

- Footnotes are automatically inserted at the bottom of the page regardless of where they are declared
- `.FS` (Footnote Start)
- `.FE` (Footnote End)
- `\**` Write the footnote number as superscript
- The following example cites the footnote number and then writes the content of the footnote to be inserted at the bottom of the page

```groff
This text is in need of extra context.\**
.FS
This is the extra context we needed in the form of a footnote
.FE
Now the rest of the paragraph can proceed.
```

---

## Text Size

- `.SM` Decrement font size by 2 points (can be called multiple times)
- `.LG` Increment font size by 2 points (can be called multiple times)
- `.NL` Restore font size

---



## Text Style
- Style is controlled by the `\f` command followed by square brackets
	- `\f[B]` (bold)
	- `\f[C]` (constant width [monospace])
	- `\f[BI]` (bold *and* italic)
	- `\f[R]` (Regular [Roman])
```groff
\f[CBI]This text is monospaced, bold, and italic. \f[R]This text is regular.
```

- Text can be boxed using the `.BX` command

```groff
.BX "This text is in a box"
```

- Text can be underlined using the `.UL` command

---

## Text color

- Color is controlled by the `\m` command followed by square brackets

```groff
\m[red]this is red text\m[green]this is green text\m[black]this is black text.
```

---

## Special characters

```
\(Do   Dollar $
\(Eu   Euro €
\(Po   British pound sterling £
\(aq   Apostrophe quote '
\(bu   Bullet sign •
\(co   Copyright ©
\(cq   Single closing quote (right) ’
\(ct   Cent ¢
\(dd   Double dagger ‡
\(de   Degree °
\(dg   Dagger †
\(dq   Double quote (ASCII 34) "
\(em   Em-dash —
\(en   En-dash –
\(hy   Hyphen ‐
\(lq   Double quote left “
\(oq   Single opening quote (left) ‘
\(rg   Registered sign ®
\(rq   Double quote right ”
\(rs   Printable backslash character \
\(sc   Section sign §
\(tm   Trademark symbol ™
\(ul   Underline character _
\(==   Identical ≡
\(>=   Larger or equal ≥
\(<=   Less or equal ≤
\(!=   Not equal ≠
\(->   Right arrow →
\(<-   Left arrow ←
\(+-   Plus-minus sign ±
```

---

## Preprocessors

- `eqn`: Equations
- `tbl`: Tables
- `refer`: Citations
- `pic`: Vector graphics
- `chem`: Chemical Equations (extension of `pic`)

---

## EQN

- All text between `.EQ` and `.EN` will be formatted as a mathematical equation
```groff
Let's show off the power of EQN by writing the quadratic formula in groff!
.EQ
x = {-b +- sqrt {b sup 2 - 4ac}} over 2a
.EN
```

---

## TBL

- All text between `.TS` and `.TE` will be formatted as a table
```groff
.TS
allbox expand;
l l.
Email	mfeigenbaum23@gmail.com
Github	https://github.com/mrf-dot
Website	https://mrf-dot.github.io
YouTube	https://www.youtube.com/channel/UCdJoCFI6t7DTzms9Cr3U0hQ
.TE
```

---

## Compilation

- `groff` uses pipes to convert preprocessors to `roff` code

```sh
eqn file.ms | groff | ps2pdf
```

- The `groff` command has build in flags to include preprocessors
- An output device can be chosen by using the `-T` flag

```sh
groff -e -Tpdf file.ms > file.pdf
```

- The `grog` command will automatically assume preprocessors based on file contents and run the command

```sh
grog -Tpdf file.ms --run > file.pdf
```

---

## Writing Groff with Vim

- Add these commands to your vim config to make writing groff easier

```vim
augroup Roff
	autocmd!
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man,*.mla set filetype=groff
	autocmd BufWritePost *.ms,*.me,*.mom,*.man,*.mla :execute '!grog -Tpdf % --run > %:t:r.pdf' | redraw
augroup END
```

---

## Example Groff file

```groff
.TL
A file
.AU
<Your name>
.AI
Unix User Group
.PP
Hello, world!
```

---

# Live Demonstration

Follow along at <https://github.com/mrf-dot/proguide>

---

## Extra resources

- Luke Smith makes a few good videos that show the basics of `groff` and `eqn`.
	- Groff_MS tutorial - <https://www.youtube.com/watch?v=w8EKH_fjmXA>
	- EQN tutorial - <https://www.youtube.com/watch?v=sp0qgpeG6EY>
- Manpages for groff
	- The groff ms macro - <https://man7.org/linux/man-pages/man7/groff_ms.7.html>
	- Insert mathematical and non-ASCII characters into groff - <https://man7.org/linux/man-pages/man7/groff_char.7.html>
	- Use grog to infer compiler flags - <https://man7.org/linux/man-pages/man1/grog.1.html>
	- Write mathematical formulae - <https://linux.die.net/man/1/eqn>
	- Format tables - <https://linux.die.net/man/1/tbl>
