$ write sys$output "Compiling..."
$ f90 ellipse
$ write sys$output "Linking..."
$ link90 ellipse
