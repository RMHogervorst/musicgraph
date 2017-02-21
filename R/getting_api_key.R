#' Getting your api key and making sure the package works.
#'
#' It took me a while to find out how you get your api key. So I wrote this
#' little documentation. For every request to musicgraph you will need an api key.
#' The good
#' thing is, that you can register on \link{https://developer.musicgraph.com}
#' and for most uses you can use the key for free. There is a rate limit of
#' 50 calls per minute and you cannot use social features.
#'
#' @section instructions on how to find the key online
#' - create an account
#' - log in
#' - go to dashboard
#' - click on applications
#' - fill in some details about the app. (if you like)
#' - copy the key
#'
#'
#' @section Where to put the key
#' You can work with a loose key if you supply it with every call.
#' However this is tedious work and not to mention insecure.
#' The key you recieve is a secret and it's best not to share the secred with
#' others or leave the key hanging around. However, everything you type in the
#' console is written to the .rhistory file in the project home directory.
#' If you accidentely share that file to github, your key is on the internet.
#' Following best practices that should work for every OS this package looks in
#' Sys.getinv(), and those setting are either set during a session or loaded
#' from files, in particular R searches for a .Renviron file in the base folder
#' of your filesystem. For windows users that is usually something like
#' C://My_documents. But don't guess, use the R-command: path.expand("~") and
#' go to that folder. search for a file called .Renviron (it starts with a dot)
#' and may be hidden. But R can see it, so if you navigate to that folder in R
#' you will see the file. If the file does not exist (that can happen) you can
#' create it. Make a simple text file with a text editor (not Microsoft word,
#' less fancy is better). Add a line which says: MUSICGRAPH_KEY (all capital
#' letters) followed by a equal sign "=" and then your key.
#' For instance (these are random letters and numbers so this key doesn't work)
#' MUSICGRAPH_KEY = "edx143owa9nv5moebgitcdhfd08lo886"
#'
#' Restart R and the package and the key is loaded. There is nothing that you
#' have to do afterwards, for every call the program searches for the key and
#' adds it to your request.
#'
#' TLDR:
#' This package looks for the key MUSICGRAPH_KEY (all caps) in the sys.env,
#' you set that key by navigating to the file .Renviron in path.expand("~").
#' If there is no .Renviron there, create a new file and add the following entry
#' MUSICGRAPH_KEY = "edx143owa9nv5moebgitcdhfd08lo886"  Where you change the key
#' to the key that YOU use. Restart R (ctrl/cmd + shift + f10). You are good
#' to go.
#'
#' For more info about api packages best practices check the vignette
#' of the httr package \link{https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html}
#'
#' @name getting_api_key
NULL
