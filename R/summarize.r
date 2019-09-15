## This file is part of arata.

## arata is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, under version 3 of the License.

## arata is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with arata.  If not, see <https://www.gnu.org/licenses/>.


#' summarize a variable list, giving basic descriptive statistics
#'
#' @param varlist a variable list either in "var1 var2 x*" form or ~var1+var2+x1+x2+x3 form.
#' @param detail if TRUE, provide a more detailed output for each variable
#' @export
summarize <- function (varlist, detail=FALSE)
{
  if (!inherits(varlist, "formula"))
  {
    varlist <- varlist(varlist)
  }
  vars <- attr(terms(varlist), "term.labels")
  detail <- detail

  for (i in 1:length(vars))
  {
    eval(substitute({
      out <- paste0("Mean: ", mean(data[,vars[i]]),
                    "\nMedian: ", median(data[,vars[i]]),
                    "\nStandard Deviation: ", sd(data[,vars[i]]),
                    "\nMin: ", min(data[,vars[i]]),
                    "\nMax: ", max(data[,vars[i]]))
      if (detail)
      {
        out <- paste0(out,
                      "\n10% Quantile: ", quantile(data[,vars[i]],prob=0.10),
                      "\n25% Quantile: ", quantile(data[,vars[i]],prob=0.25),
                      "\n75% Quantile: ", quantile(data[,vars[i]],prob=0.75),
                      "\n90% Quantile: ", quantile(data[,vars[i]],prob=0.90))
      }
      out <- paste0(out,"\n")
      cat(out)
    }), envir=data.env)
  }
}


