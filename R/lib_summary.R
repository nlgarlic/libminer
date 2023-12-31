#' R Library Summary
#'
#'Provides a brief summary of package libraries.
#'
#' @param sizes A logical value indicated whether to caclulate sizes. Default 'FALSE'.
#'
#' @return A 'data.frame' containing the count of packages. If 'sizes = TRUE', a column of library sizes will be added.
#' @export
#'
#' @examples
#' lib_summary()
#' lib_summary(sizes = TRUE)
lib_summary <- function(sizes = FALSE) {
  if (!is.logical(sizes)) {
    stop("sizes must be a logical value (TRUE/FALSE)")
  }

  pkgs <- utils::installed.packages()
  pkg_tbl <- table(pkgs[,"LibPath"])
  pkg_df <- as.data.frame(pkg_tbl, stringsAsFactors = FALSE)
  names(pkg_df) <- c("Library", "n_packages")

  if(isTRUE(sizes)) {
    pkg_df$lib_size <- vapply(
      pkg_df$Library,
      function(x) {
        sum(fs::file_size(fs::dir_ls(x, recurse = TRUE)))
      },
      FUN.VALUE = numeric(1)
    )
  }

  pkg_df
}
