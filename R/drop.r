## This file is part of rata.

## rata is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, under version 3 of the License.

## rata is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with rata.  If not, see <https://www.gnu.org/licenses/>.


#' drops rows from the dataset
#'
#' @param x a condition like (ex: "var1==2") describing the observations that should be removed from the data set.
#' @examples
#' use(cars)
#' listif()
#' dropif("speed <= 20")
#' listif()
#'@export
dropif <- function (x)
{

  eval(substitute({
    rows <- with(data, which(eval(parse(text=x))))
    data <- data[-rows,]}), envir=data.env)
  postuse()
}

#' drops variables in varlist format from the dataset
#' @param x a varlist either in "var1 var2 var3" format or ~var1+var2+var3 format.
#' @examples
#' use(cars)
#' listif()
#' dropvar("speed")
#' listif()
#' use(cars)
#' dropvar(~speed)
#' listif()
#' @export
dropvar <- function (x)
{
  if (!inherits(x,"formula"))
  {
    x <- varlist(x)
  }

  form <- as.Formula(x)
  vars <- attr(terms(formula(form,lhs=0,rhs=1)), "term.labels")
  eval(substitute({data[,vars] <- NULL}),envir=data.env)
  postuse()
}

#' keeps some rows in the dataset and drops the rest
#'
#' 
#' @param x a condition like: "var1==2" in which case observations that satisfy the condition are kept and all others are removed.
#' @examples
#' use(cars)
#' keepif("speed <= 20")
#' listif()
#' @export
keepif <- function (x)
{
  rows <- with(data, which(eval(parse(text=x))))
  eval(substitute({data <- data[rows,]}), envir=data.env)
  postuse()
}

#' keeps some variables in the dataset and drops the others
#'
#' @param x a varlist either of the form "var1 var2 var3" or in the form ~var1+var2+var3.
#' @examples
#' use(cars)
#' keepvar("speed")
#' listif()
#' use(cars)
#' keepvar(~speed)
#' listif()
#'@export
keepvar <- function (x)
{
  if (!inherits(x,"formula"))
  {
    x <- varlist(x)
  }
  form <- as.Formula(x)
  vars <- attr(terms(formula(form,lhs=0,rhs=1)), "term.labels")

  eval(substitute({data <- data[,vars]}),envir=data.env)
  postuse()
}
