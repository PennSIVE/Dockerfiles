## Setup R environment

---
### **pennsive/r-env:base**
R environment based on neurodebian (buster), with ANTsR, extransr, fslr, etc installed. You can start an interactive shell with the `-it` flag, or run a single script. For example, `docker run -ti pennsive/r-env:base` will drop you in a bash shell (from which you can start R), `docker run -ti pennsive/r-env:base R` will drop you in an R shell straight away, or `docker run --rm pennsive/r-env:base Rscript -e "2 + 2"` to run a single script, etc. Most of the time you will need to share files on your computer with the container. The easiest way to do so is by bind mounting them: `docker run --rm -v /path/on/yourcomputer/:/mydata pennsive/r-env:base Rscript /mydata/myscript.R` which will execute `/path/on/yourcomputer/myscript.R` in the containers environment, then remove the container (`--rm` flag) when done.


--- 
### **pennsive/r-env:rstudio**
r-env:base with R studio installed. You can start the R studio webserver on port 80 (or any other port of your choosing) with `docker run -d -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio`. Like all containers, you can customize the init command by appending to the end of the docker run command. However, the default command, `/init` is needed to start the webserver so doing `docker run -ti -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio R` will start an interactive shell but won't start the webserver. To start both an interactive shell and web server in the same container, you would have to run `docker run -ti -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio bash -c "(/init &) ; R"`, though it would be better practice to run r-env:base and r-env:rstudio as different containers.

---

### **pennsive/r-env:freesurfer**
r-env:base with freesurfer installed. Can not be started without providing a freesurfer license as an environment variable. For example, `docker run -e FREESURFER_LICENSE="xxx" -ti --rm pennsive/r-env:freesurfer`. Contact Tim for an actual license or apply for your own [here](https://surfer.nmr.mgh.harvard.edu/registration.html).



