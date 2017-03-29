\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csci1933}[2017/01/19 v0.1 CSCI 1933 LaTeX class]
\LoadClass[11pt,letterpaper]{article} % this is based off of article

\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{amsmath,amssymb,amsthm} % math
\RequirePackage[headheight=110pt,margin=1in]{geometry} % page margins
\RequirePackage[sf,bf,pagestyles]{titlesec} % section headings \sffamily\bfseries
\RequirePackage{titling} % format title
\RequirePackage{abstract} % format abstract
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
\RequirePackage{listings, lstautogobble} % for code
\RequirePackage[symbol,bottom]{footmisc}
\RequirePackage{fancyhdr} % header/footer
\RequirePackage{enumitem}
\RequirePackage{graphicx}
\RequirePackage{tikz} % drawing things
\RequirePackage[plain]{algorithm} % algorithm typsetting
\RequirePackage{algpseudocode}
\RequirePackage{etoolbox}
\RequirePackage{float}
\RequirePackage{tocloft}
\RequirePackage[colorlinks,bookmarks=false]{hyperref}

% the number of the lab/project
\def \num#1{\def\@number{#1}}
\def \@number {??}

\def \@course {CSCI 1933}
\def \@lefthead {} % by default empty

\DeclareOption{lab}{
  \def \@lefthead {{\@course} Lab {\@number}}

  \patchcmd{\@maketitle}{\@title}{{\@lefthead} \\ \Large \@title{}}{}{}

  \renewcommand{\sectionmark}[1]{\markright{\thesection.\ \MakeUppercase{#1}}}
  \renewcommand{\subsectionmark}[1]{}
  \renewcommand{\subsubsectionmark}[1]{}

  \lhead{\MakeUppercase{\@lefthead}}
  \rhead{\rightmark}
  \renewcommand{\headrulewidth}{0.4pt}
}

\DeclareOption{project}{
  \def \@lefthead {{\@course} Project {\@number}}

  \patchcmd{\@maketitle}{\@title}{{\@lefthead} \\ \Large \@title{}}{}{}

  \renewcommand{\sectionmark}[1]{\markright{\thesection.\ \MakeUppercase{#1}}}
  \renewcommand{\subsectionmark}[1]{}
  \renewcommand{\subsubsectionmark}[1]{}

  \lhead{\MakeUppercase{\@lefthead}}
  \rhead{\rightmark}
  \renewcommand{\headrulewidth}{0.4pt}
}

\DeclareOption{rubric}{
  \def \@lefthead {{\@course} Project {\@number} Rubric}
  \lhead{}
  \rhead{}
  \renewcommand{\headrulewidth}{0pt}

  \patchcmd{\@maketitle}{\@title}{{\@lefthead} \\ \Large \@title{}}{}{}
}

\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}

\renewcommand{\headrulewidth}{0pt}
\lhead{}
\rhead{}

\cfoot{\thepage}
\pagestyle{fancy}

\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \lhead{}
  \rhead{}
}

\ProcessOptions

% section/tite font setup {{{
% make title elements \sffamily
\pretitle{\begin{center}\bfseries\sffamily\LARGE}

  % move title to top of page
\posttitle{\par\end{center}}
\setlength{\droptitle}{-60pt}
\title{} % default title is empty

% don't need author or date in these types of documents
\preauthor{}
\postauthor{}
\predate{}
\postdate{}
\date{\vspace{-35pt}} % not the best way to do it, but meh
\author{}

% make abstract title \sffamily and fix spacing with vspace h4xing
\renewcommand\abstractnamefont{\sffamily}
\addto{\captionsenglish}{\renewcommand{\abstractname}{\vspace{20pt}Abstract\vspace{-20pt}}}

% make description title \bfseries\sffamily
\setlist[description]{%
  font={\bfseries\sffamily}, % set the label font
}
% }}}

\setlength\parindent{0pt} % no indent by default
\setlength{\parskip}{\baselineskip} % add space between paragraphs
\titlespacing\section{0pt}{5pt}{1pt}       % \
\titlespacing\subsection{0pt}{5pt}{1pt}    %  |- remove spacing around section headings
\titlespacing\subsubsection{0pt}{5pt}{1pt} % /

\newcommand{\forceindent}{\leavevmode{\parindent=1em\indent}} % force an indent

\linespread{1.2} % aesthetics, yo

% java syntax highlighting
\definecolor{mygreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mymauve}{rgb}{0.58,0,0.82}
\lstset{
  language                = Java,
  showspaces              = false,
  showtabs                = false,
  breaklines              = true,
  showstringspaces        = false,
  commentstyle            = \color{mygreen},
  keywordstyle            = \color{blue},
  numberstyle             = \tiny\color{mygray},
  stringstyle             = \color{mymauve},
  basicstyle              = \ttfamily,
  autogobble              = true,
  columns                 = fullflexible,
  mathescape,
  moredelim               = **[is][\color{mygreen}]{@}{@},
  moredelim               = [s][\color{pgreen}]{`}{'},
}

\newcommand{\java}[1]{\lstinline{#1}}
\newcommand{\code}[1]{\lstinline{#1}}

\newtcolorbox{notebox}[3][]{
  colback                 = #3!5,
  colframe                = black!70!#3,
  coltitle                = black!40!#3,
  arc                     = 1pt,
  boxrule                 = 0.5pt,
  attach title to upper,
  after title             = {:\ },
  title                   = {#2},
  fonttitle               = \bfseries\sffamily,
  #1,
}

% table of contents formatting
\addto\captionsenglish{
  \renewcommand{\contentsname}{\bfseries\sffamily Contents}
}
\renewcommand{\cftsecfont}{\bfseries\sffamily}
\renewcommand{\cftsubsecfont}{\sffamily}
\renewcommand{\cftsubsubsecfont}{\sffamily}
\renewcommand{\cftsecpagefont}{\bfseries\sffamily}
\renewcommand{\cftsubsecpagefont}{\sffamily}
\renewcommand{\cftsubsubsecpagefont}{\sffamily}

% hack to fix old version of package deleting section numbers
\makeatletter
\patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}
\patchcmd{\ttlh@hang}{\noindent}{}{}{}
\makeatother
