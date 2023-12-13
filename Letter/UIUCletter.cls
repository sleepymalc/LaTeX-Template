\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UIUCletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
%\RequirePackage{fontspec}
\DeclareGraphicsExtensions {.png} %{.pdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newboolean{logofound}
\IfFileExists{Figures/logo.png}
{\setboolean{logofound}{true}}
{\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
        {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}

        % HELP FOR SETTING UP PARBOXES
        % \parbox[position][height][inner-pos]{width}{text}
        % The \parbox has two mandatory arguments:
        %     width - specifies the width of the parbox, and
        %     text - the text that goes inside the parbox. 
        % LaTeX will position a parbox so its center lines up with the center of the text line. The optional position argument allows you to line up either the top or bottom line in the parbox (default is top).
        % If the height argument is not given, the box will have the natural height of the text.
        % The inner-pos argument controls the placement of the text inside the box. If it is not specified, position is used.
        %     t -- text is placed at the top of the box.
        %     c -- text is centred in the box.
        %     b -- text is placed at the bottom of the box.
        %LOGO
        %
        \parbox{.56\textwidth}
        {\raggedright
            \ifthenelse{\boolean{logofound}}
            {\epsfig{file=Figures/logo.png, width=0.55\textwidth}}
            {\parbox[t][1.0in][t]{2.0in}{\hfill}
                \ClassWarning{UIUCletter}{Figures/logo.png COULD NOT BE FOUND!}}
        } &
        %DEPARTMENT OR SCHOOL
        %  This just sets the size of the box to the right of the logo, and the size of the vertical line.  The vertical line is set by the size of the first numerical argument of the \parbox command.
        %
        % In the future, the "From" address might be better set using "tikz".
        \parbox[c][1.2in][c]{2.225in}{{~}\\
        }\\
    \end{tabular*}
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
\ifx\@empty\fromaddress
    %{\raggedleft\@date\par}%
\else  % home address
    {\raggedleft
        \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
        \end{tabular}\par
    }%
\fi
\vspace{-6\parskip}
\@date \vspace{2\parskip}\\
{\raggedright \toname \\ \toaddress \par}%
\vspace{1\parskip}%
\ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
\vspace{1\parskip}%
#1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.6\textwidth}\parbox{0.4\textwidth}{\raggedright
        \ignorespaces #1\\[4\medskipamount]%
        \ifx\@empty\fromsig
            \fromname
        \else \fromsig
        \fi\strut}%
    \par
}