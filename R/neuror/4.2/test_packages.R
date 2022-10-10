# Test if packages are installed
pkg_df = read.csv('/work/Rpackages.csv')
installed = installed.packages()

for (name in pkg_df$name){
    # Handle packages from GitHub
    if (grepl('/', name)) name = strsplit(name, '/')[[1]][2]
    # Print message if package not installed
    if(! name %in% installed){
        message(sprintf("Package '%s' is not installed.", name))
    }
}