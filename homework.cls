%% homework.cls  Copyright (C) 2020  Ahmad Tashfeen
%% This program comes with ABSOLUTELY NO WARRANTY.
%% This is free software, and you are welcome to
%% redistribute it under certain conditions; read
%% file COPYING for more details.

% Put in /usr/local/texlive/texmf-local/tex/latex/local
% And then re-index, see: tex.stackexchange.com/q/1137/215221
% Latex documentation: https://en.wikibooks.org/wiki/LaTeX
% 'em' is the horizontal space unit and 'ex' is the vertical

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2021/01/01 Homework]
\DeclareOption{handout}{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax
\LoadClass[12pt, oneside]{amsart}
\RequirePackage[letterpaper, margin=0.5in]{geometry} % For margins
\RequirePackage{lmodern, enumitem, needspace} % Needspace for dynamic line breaking
\RequirePackage{graphicx, wrapfig, pgffor, ifthen} % For images, wrappings and if statements
\RequirePackage[normalem]{ulem} % For better underlining and org-mode
\RequirePackage[font=small]{caption} % For caption resizing with wrapfig
\RequirePackage[caption=false]{subfig}
\RequirePackage{hyperref} % For pdf bookmarks, other information and org-mode
\RequirePackage{hwsymb, hwlst} % By Tashfeen
\RequirePackage{mathtools, amssymb, amsthm, enumitem}
\hypersetup {
  pdfstartview=FitH,
  colorlinks=true,
}

% Induction environment
\newenvironment{subproof}
{\def\proofname{Subproof}%
  \def\qedsymbol{$\triangleleft$}%
  \proof}
  {\endproof}

% Part command
\gdef\@partename{Parte}
\newcounter{ParteCounter}
\setcounter{ParteCounter}{1}
\newcommand{\setparte}[1]{\gdef\@partename{#1}}
\newcommand{\parte}[1][\alph{ParteCounter}] {
  \def\@currentlabel{#1}
  \setcounter{section}{1}
  \renewcommand{\thesection}{#1.\alph{section}}
  \renewcommand{\theHsection}{#1.\the\value{section}}
  \addcontentsline{toc}{part}{#1. \@partename{}}
  \vspace*{0.5\baselineskip}\needspace{8\baselineskip}
  \noindent\textbf{\@partename{} #1. }\ignorespaces
  \ifthenelse{\equal{#1}{\alph{ParteCounter}}}
  {\stepcounter{ParteCounter}}{}
}

% Question command
\gdef\@unitname{Pregunta}
\newcounter{UnitCounter}
\newcommand{\setunitname}[1]{\gdef\@unitname{#1}}
\newcommand{\question}[1][\arabic{UnitCounter}] {
  \setcounter{ParteCounter}{1}
  \def\@currentlabel{#1}
  \ifthenelse{\equal{#1}{\value{UnitCounter}}}
  {\stepcounter{UnitCounter}}{}
  \setcounter{section}{0}
  \renewcommand{\thesection}{#1.\arabic{section}}
  \renewcommand{\theHsection}{#1.\the\value{section}}
  \addcontentsline{toc}{part}{#1. \@unitname{}}
  \vspace*{0.5\baselineskip}\needspace{8\baselineskip}
  \noindent\textbf{\@unitname{} #1. }\ignorespaces
}

% Bonus question environment
\theoremstyle{definition}
\newtheorem{bonus}{\@unitname{} (Bonus)}

% For right aligned figure
\newcommand{\rightfig}[4][0.4] {
  \begin{wrapfigure}{r}{#1\textwidth}
    \centering
    \vspace{-3ex}
    \includegraphics[width=#1\textwidth]{#2}
    \vspace{-3ex}
    \caption{#3}
    \vspace{-1ex}
    \label{#4} % has to stay after caption
  \end{wrapfigure}
}

% Just one or a list of figures
\newcommand{\fig}[4][0.4]{
  \begin{figure}[hbtp]
    \foreach \elem in {#2} {
      \begin{minipage}{#1\textwidth}\centering
        \subfloat {
          \includegraphics[width=\linewidth]{\elem}
        }
      \end{minipage} % minipage for easy centring
    }
    \caption{#3}\label{#4}
  \end{figure}
}

% This handles the info tags at the beginning
\makeatletter
  \gdef\@author{\empty}
  \gdef\@class{\empty}
  \newcommand{\class}[1]{\gdef\@class{#1}}
  \newcommand{\rol}[1]{\gdef\@rol{#1}}
  \newcommand{\logo}[1]{\gdef\@logo{#1}}
  \newcommand{\ayudante}[1]{\gdef\@ayudante{#1}}
  \renewcommand{\author}[1]{\gdef\@author{#1}}
  \renewcommand{\maketitle} {
    \begin{minipage}{.45\linewidth}
      \bgroup
      \setlength{\parindent}{0em}
      \begin{flushleft}
        \ifthenelse{\equal{\@author}{\empty}}{}{Alumno: \@author\\}
        \ifthenelse{\equal{\@rol}{\empty}}{}{Rol: \@rol\\}
        \ifthenelse{\equal{\@class}{\empty}}{}{\@class\\}
        \ifthenelse{\equal{\@ayudante}{\empty}}{}{Ayudante: \@ayudante\\}
        \@date
      \end{flushleft}
      \egroup
    \end{minipage}
    \begin{minipage}{.45\linewidth}
      \begin{flushright}
        \includegraphics[height=4cm, width=4cm]{\@logo}
      \end{flushright}
    \end{minipage}
    \begin{center}
      \textbf{\@title} \\
    \end{center}
    \bigskip
  }
\makeatother
