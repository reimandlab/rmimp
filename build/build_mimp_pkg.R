setwd('~/Development/mimp/')

VERSION = '1.0'

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
  require(devtools)
  targz = sprintf('rmimp_%s.tar.gz', VERSION)
  # Move up one directory
  newf = file.path('./build', targz)
  # Compile things
  document('./')
  file.remove(newf)
  system('R CMD BUILD ./')
  re = file.rename(targz, newf)
  # Install package
  system(sprintf('R CMD INSTALL %s', newf))
  # Reload in current environment
  detachPackage('rmimp')
  #require(rmimp)
  
  man_files = list.files('man/', full.name=T)
  rm_man = man_files[!grepl('mimp|results2html', man_files)]
  X = sapply(rm_man, function(from) file.rename(from, basename(from)))
  system('R CMD Rd2pdf --no-index --no-preview --force -o build/rmimp_manual.pdf ./')
  X = sapply(basename(rm_man), function(from) file.rename(from, file.path('man', from)))
  
  file.copy('build/rmimp_manual.pdf', '~/Development/mimp_webserver/public/R/generate_data/rmimp_manual.pdf')
}

# Build package
build_package()