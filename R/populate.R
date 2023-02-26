#' Create a number of random source files
#' @param n number of files
#' @export
populate <- function(path = "R", n = 1) {
  ns_names <- c("base", "stats", "utils")
  objs <- lapply(nss, function(ns_name) {
    syms <- getNamespaceExports(ns_name)
    ns <- asNamespace(ns_name)
    objs <- lapply(syms, function(sym) {
      obj <- get0(sym, ns, ifnotfound = NULL)
      if (is.function(obj) && length(formals(obj)) && length(body(obj))) {
        expr <- substitute(name <- fun, list(
          name = as.name(paste0("test_", sym)),
          fun = obj
        ))
      }
    })
  })
}
