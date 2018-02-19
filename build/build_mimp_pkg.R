if (basename(getwd()) != 'rmimp')
  stop('Please execute this script from the root of the repository (make sure it is called "rmimp")')
  # use: Rscript build/build_mimp_pkg.R

source('R/Rmimp.R')
require(roxygen2)
require(devtools)

detachPackage <- function(pkg){
  pkg = sprintf("package:%s", pkg)
  res = tryCatch({
    detach(pkg, unload=TRUE, character.only=T, force=T)
    TRUE
  }, error = function(e) {
    FALSE
  })
  return(res)
}

build_package <- function(){
  # Update description file
  desc = readLines('DESCRIPTION')
  desc[grep('Version', desc)] = sprintf('Version: %s', .MIMP_VERSION)
  desc[grep('Date', desc)] = sprintf('Date: %s', Sys.Date())
  writeLines(desc, 'DESCRIPTION')

  expected_archive_name = sprintf('rmimp_%s.tar.gz', .MIMP_VERSION)
  target_archive_path = file.path('./build', expected_archive_name)

  # Compile things
  document('./')

  if (file.exists(target_archive_path)) file.remove(target_archive_path)
  
  built_archive_path = build()
  file.rename(built_archive_path, target_archive_path)

  # Install package
  install()

  # Reload in current environment
  detachPackage('rmimp')

  # man_files = list.files('man/', full.names = T)
  # rm_man = man_files[!grepl('mimp|results2html', man_files)]
  # X = sapply(rm_man, function(from) file.rename(from, basename(from)))
  system('R CMD Rd2pdf --no-index --no-preview --force -o build/rmimp_manual.pdf ./')
  # X = sapply(basename(rm_man), function(from) file.rename(from, file.path('man', from)))
  # file.copy('build/rmimp_manual.pdf', '~/Development/mimp_webserver/public/R/generate_data/rmimp_manual.pdf')
}

# Build package
build_package()
