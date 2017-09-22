#################################################################################
##
##   R package sutteForecastR by Ansari Saleh Ahmar Copyright (C) 2015-2035.
##   This file is part of the R package sutteForecastR
##
##   The R package sutteForecastR is free software: you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
##
##   The R package sutteForecastR is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
#################################################################################

if(getRversion() >= "2.15.1") {
  utils::globalVariables("top")
  utils::globalVariables("buttonsFrame")
}

.onAttach <-
  function(libname, pkgname){
    if (!interactive()) return()
    Rcmdr <- options()$Rcmdr
    plugins <- Rcmdr$plugins
    if ((!pkgname %in% plugins) && !getRcmdr("autoRestart")) {
      Rcmdr$plugins <- c(plugins, pkgname)
      options(Rcmdr=Rcmdr)
      closeCommander(ask=FALSE, ask.save=TRUE)
      Commander()
    }

	  version <- read.dcf(file.path(libname, pkgname, "DESCRIPTION"), "Version")

	  if(interactive())
	  {
		packageStartupMessage(
	"
                      __
		  /  |     /  RcmdrPlugin.sutteForecastR: Rcmdr plugin for sutteForecastR
		 /_| |__  /_| Alpha-Sutte Indicator by Ansari Saleh Ahmar
		   |    |   | Ahmar, A.S. (2017) <doi:10.17605/osf.io/rknsv>
		   |  __|   | version ", version)
	  }
	  else
	  { packageStartupMessage("", version) }

	  packageStartupMessage("
		 Universitas Negeri Makassar, Indonesia
	")
	  invisible()

}


alphasutte <- function(){
  initializeDialog(title=gettextRcmdr("alpha-Sutte Indicator"))
   xBox <- variableListBox(top, Numeric(), title=gettextRcmdr("Variable (pick one)"))
    onOK <- function(){
        x <- getSelection(xBox)
     if (length(x) == 0){
            errorCondition(recall=alphasutte, message=gettextRcmdr("You must select a variable."))
            return()
            }
        closeDialog()
    doItAndPrint(paste("alpha.sutte(", ActiveDataSet(), "$",x,")",sep=""))		
        tkdestroy(top)
        tkfocus(CommanderWindow())
        }
    OKCancelHelp(helpSubject="alpha.sutte")
   tkgrid(getFrame(xBox), sticky="nw") 
    tkgrid(buttonsFrame, columnspan=2, sticky="w")
     dialogSuffix(rows=4, columns=2)
}
