% vim ft=tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mybeamer}[2016/10/01 v0.0.1 Daniele Liciotti modified Beamer]

\RequirePackage[svgnames]{xcolor}
\LoadClassWithOptions{beamer}[2005/06/12]
\RequirePackageWithOptions{graphicx}
\hypersetup{colorlinks=false}

%
% Impostazione del layout grafico
%

%%% Configurazioni di beamer
\usetheme{Madrid}

%%% Colori dei blocchi di codice
\definecolor{LC background}{rgb}{1,.97,.86}
\colorlet{LC foreground}{DarkBlue}
\colorlet{LC alerted fg}{DarkRed}

\setbeamercolor{alerted text}{fg=blue}% Il colore degli alert e` blu
\setbeamercolor{aalerted text}{fg=red}% Il colore degli aalert e` rosso
\setbeamercolor{LaTeX code}{fg=LC foreground,bg=LC background}
\setbeamercolor{alerted LaTeX code}{fg=LC alerted fg,bg=LC background}

%%% Ridefinisco la footline
\defbeamertemplate*{footline}{infolines}
{
  \leavevmode%
  \hbox{%
  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{author in head/foot}%
    \usebeamerfont{author in head/foot}\insertshortauthor
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{title in head/foot}%
    \usebeamerfont{title in head/foot}\insertshorttitle
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
    \usebeamerfont{date in head/foot}\insertshortdate{}\hspace*{2em}
    \insertframenumber{} / \inserttotalframenumber\hspace*{2ex} 
  \end{beamercolorbox}}%
  \vskip0pt%
}

%
% Definizioni utili
%

%%% Definisco un comando \aalert
%%% Utilizzo: \aalert{ argomento }
\newcommand<>{\aalert}[1]{\begin{alertenv}#2\usebeamercolor[fg]{aalerted text}#1\end{alertenv}}

%
% Comandi per la scrittura del codice LaTeX e del relativo output
%
\newcommand{\bs}{{\char'134}}% Backslash
\newcommand{\lb}{{\char'173}}% Left brackets -> {
\newcommand{\rb}{{\char'175}}% Right brackets -> }
\newcommand{\ls}{{\char'133}}% Left brackets -> [
\newcommand{\rs}{{\char'135}}% Right brackets -> ]

%
% Comandi per la scrittura di classi, pacchetti, ecc.
%

%%% Definisco il comando per nominare i pacchetti
%%% Utilizzo: \Lsty{ nome_classe_o_pacchetto }
\newcommand<>{\Lsty}[1]{\begin{actionenv}#2\usebeamercolor[fg]{structure}\ttfamily #1\end{actionenv}}
%%% Definisco \Lcls nella stessa maniera di \Lsty
\let\Lcls\Lsty
%%% \Lopt e` un comando per nominare le opzioni delle classi
\def\Lopt#1{\LCmd[]{#1}}
%%% \Lenv e` un comando per nominare gli ambienti
\let\Lenv\Lopt


%%% LaTeXcode serve per scrivere codice in blocco a se stante ed
%%% e` basato sul codice di 'semiverbatim', classe beamer.
%%% Utilizzo: \begin{LaTeXcode}[ eventuale_titolo ]
%%%             \n \nn \alert{ }
%%%           \end{LaTeXcode}
\newenvironment<>{LaTeXcode}[1][]%
{\begin{actionenv}#2%
  \def\insertblocktitle{#1}%
  \setbeamercolor{block body}{fg=LC foreground,bg=LC background}
  \newcommand{\n}{\newline}% Interruzione di riga singola
  \newcommand{\nn}{\newline\null\newline}% Interruzione di riga doppia
  \renewcommand*{\alert}[1]{{\usebeamercolor[fg]{alerted LaTeX code}##1}}% Alert
  \usebeamertemplate{block begin}\hbadness=10000%
  \begin{semiverbatim}}%
  {\end{semiverbatim}%
  \usebeamertemplate{block end}
\end{actionenv}}

%%% LaTeXoutput serve per mostrare il risultato del codice.
%%% Utilizzo: \begin{LaTeXoutput}[ eventuale_titolo ]
%%%           \end{LaTeXoutput}
\newenvironment<>{LaTeXoutput}[1][]%
{\begin{actionenv}#2%
  \def\insertblocktitle{#1}%
  \newcommand{\fakeind}{\hspace*{1.5em}}% Simula l'\indent. Va usato a mano
  \usebeamertemplate{block begin}\setlength{\parindent}{1.5em}\rmfamily}%
  {\usebeamertemplate{block end}
\end{actionenv}}

%%% LCmd serve per scrivere un comando all'interno del testo.
%%% Utilizzo: \LCmd[ carattere_escape ]{ comando \\ \{ \} \ls \rs }
%%% NEW! Puo` essere usato anche nei titoli :)
\newcommand{\LCmd}[2][\char'134 ]{\begingroup%
\let\\\bs\let\{\lb\let\}\rb%
\ifx\@inframetitle\@empty%
  \usebeamercolor[fg]{LaTeX code}\ttfamily{#1}{#2}%
\else%
  \ttfamily{#1}{#2}%
\fi%
\endgroup}

%%% LCmdArg e` simile a LCmd ma mette in evidenza l'argomento.
%%% Utilizzo: \LCmdArg{ comando }{ argomento_del_comando }
%%% All'interno di \LCmdArg si possono usare gli stessi simboli di \LCmd.
\newcommand{\LCmdArg}[2]{\begingroup%
\let\\\bs\let\{\lb\let\}\rb%
\color{LaTeX code.fg}\ttfamily\char'134{#1}\char'173{\color{alerted LaTeX code.fg}{#2}}\char'175\endgroup}

%%% Per scrivere correttamente \, {, }, [ e ] nel testo
\newcommand{\tbs}{\LCmd{}}% Textual BackSlash
\newcommand{\tlb}{\LCmd[]{\lb}}% Textual Left Bracket
\newcommand{\trb}{\LCmd[]{\rb}}% Textual Right Bracket
\newcommand{\tls}{\LCmd[]{\ls}}% Textual Left Square
\newcommand{\trs}{\LCmd[]{\rs}}% Textual Right Square

\endinput
