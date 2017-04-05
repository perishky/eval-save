#' Evaluate an expression and save the result
#'
#' @param expr Expression to be evaluated.
#' @param name Unique name for later accessing the saved result.
#' @param redo If the expression has been previously evaluated and saved
#' it will normally not be re-evaluated.  This can be overridden
#' by setting this parameter to TRUE (Default: FALSE).
#' @param verbose Print status and error messages (Default: TRUE).
#' @return The result of the expression evaluation.
#'
#' @examples
#' f <- function(v) {
#'   cat(paste("f(", v, ") = ", x <- mean(runif(v)), "\n", sep=""));
#'   x
#' }
#' 
#' x <- eval.save(f(3),"f")
#' 
#' @export
eval.save <- function(expr, name, redo=F, verbose=T) {
    filename <- file.path(eval.save.dir(), paste(name, ".rda", sep=""))
    if (!file.exists(filename) || redo) {
        if (verbose) cat(paste(date(), "Evaluating", filename, "...\n"))
        ret <- NA
        save(ret, file=filename)
        tryCatch(ret <- eval(expr, envir=parent.frame()),
                 error=function(e) {
                     unlink(filename)
                     ret <<- e
                     if (verbose) stop(e)
                 })
        if (verbose) cat(paste(date(), " done.\n"))
        save(ret, file=filename)
    }
    invisible(ret)
}

load.list <- function(filename) {
    envir <- sys.frame(sys.nframe())
    object_names <- load(filename, envir=envir)
    L <- lapply(object_names, get, envir=envir)
    names(L) <- object_names
    L
}

#' Check if a result has been saved
#'
#' @param name Name given to the result.
#'
#' @examples
#'
#' x <- eval.save(f(3), "f")
#' eval.saved("f")
#' eval.saved("g")
#'
#' @export
eval.saved <- function(name) {
    filename <- file.path(eval.save.dir(), paste(name, ".rda", sep=""))
    file.exists(filename)
}


#' Load a previously saved result
#'
#' @param name Name given to the result.
#'
#' @examples
#'
#' x <- eval.save(f(3),"f")
#' eval.ret("f")
#'
#' @export
eval.ret <- function(name) {
    filename <- file.path(eval.save.dir(), paste(name, ".rda", sep=""))
    load.list(filename)$ret
}
