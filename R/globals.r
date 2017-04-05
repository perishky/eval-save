.onLoad <- function(libname, pkgname) {
    assign("globals", new.env(), envir=parent.env(environment()))
    assign("save.dir", ".eval-save", envir=globals)
}


#' Directory where evaluations are saved
#'
#' @param dir Directory where evaluation results should be saved.
#' @return The current directory where evaluations are saved.
#' 
#' @export
eval.save.dir <- function(dir) {
    if (!missing(dir)) {
        if (!file.exists(dir))
            dir.create(dir, showWarnings=F)
        assign("save.dir", dir, envir=globals)
    }
    get("save.dir",envir=globals)
}
