# Setup R environment

### Example workflow
1. Start R Studio locally, bind mounting data (and scripts, if you want) in your workspace

    Running `docker run -p 80:8787 -e DISABLE_AUTH=true -d -v /Users/tim/repos/Neurohacking_data:/home/rstudio/mydata pennsive/r-env:rstudio` will start the R Studio webserver on port 80 without a password, with the `/Users/tim/repos/Neurohacking_data` being shared into the containers `/home/rstudio/mydata`.

2. Upload data and scripts to CUBIC

    When uploading a single file `scp /path/to/file username@cbica-cluster:/cbica/home/user/file` is sufficient but when uploading a lot of data rsync will ensure partial downloads/uploads can be resumed at any time, and nothing will get redundantly transferred: `rsync -avzh --progress --stats /path/to/big/directory username@cbica-cluster:/cbica/home/user/dir`.

3. Submit job to SGE

    Once your script and data are on CUBIC, you can run a container (on the interactive login node or as an SGE job) using singularity. For example, `singularity exec -B $(pwd):/home/rstudio/mydata -B /path/to/script:/src docker://pennsive/r-env:rstudio Rscript /src/script.R` will run `/path/to/script/script.R` in the containers environment, with your data being located in the same `/home/rstudio/mydata` directory. Any container can be run on SGE by prepending `qsub-run` to your command. <u>Note</u> that the first time your run a container, the image will have to be downloaded. This takes especially a long time on singularity, so before getting started it's best to pull all the images you'll need e.g. `singularity pull docker://pennsive/r-env:base`. Pull operations can not be submitted to SGE.

4. Download results

    The same as uploading, but switching the source and destination e.g. `rsync -avzh --progress --stats username@cbica-cluster:/cbica/home/user/dir /path/to/big/directory`.

---
### Available images
#### pennsive/r-env:base
R environment based on neurodebian (buster), with ANTsR, extransr, fslr, etc installed. You can start an interactive shell with the `-it` flag, or run a single script. For example, `docker run -ti pennsive/r-env:base` (or `singularity shell docker://pennsive/r-env:base`) will drop you in a bash shell (from which you can start R), `docker run -ti pennsive/r-env:base R` (or `singularity exec docker://pennsive/r-env:base R`) will drop you in an R shell straight away, or `docker run --rm pennsive/r-env:base Rscript -e "2 + 2"` (or `singularity exec docker://pennsive/r-env:base Rscript -e "2 + 2"`) to run a single script, etc. Most of the time you will need to share files on your computer with the container. The easiest way to do so is by bind mounting them: `docker run --rm -v /path/on/yourcomputer/:/mydata pennsive/r-env:base Rscript /mydata/myscript.R` (or `singularity exec -B /path/on/yourcomputer/:/mydata docker://pennsive/r-env:base Rscript /mydata/myscript.R`) which will execute `/path/on/yourcomputer/myscript.R` in the containers environment.


--- 
#### pennsive/r-env:rstudio
r-env:base with R studio installed. You can start the R studio webserver on port 80 (or any other port of your choosing) with `docker run -d -v $(pwd):/home/rstudio/mydata -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio`. The directory you issue the command in (`pwd`) will be mounted (i.e. shared) with /home/rstudio/mydata in the container. CUBIC does not allow networking so there is no singularity command.

<sub>Note: Like all containers, you can customize the init command by appending to the end of the docker run command. However, the default command, `/init` is needed to start the webserver so doing `docker run -ti -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio R` will start an interactive shell but won't start the webserver. To start both an interactive shell and web server in the same container, you would have to run `docker run -ti -e DISABLE_AUTH=true -p 80:8787 pennsive/r-env:rstudio bash -c "(/init &) ; R"`, though it would be better practice to run r-env:base and r-env:rstudio as different containers.</sub>

---

#### pennsive/r-env:freesurfer
r-env:base with freesurfer installed. Can not be started without providing bind mounting the freesurfer license into the container. For example, `docker run -v $(pwd)/license.txt:/usr/local/freesurfer/license.txt -ti --rm pennsive/r-env:freesurfer` (or `singularity shell -B $(pwd)/license.txt:/usr/local/freesurfer/license.txt docker://pennsive/r-env:freesurfer`). Contact Tim for an actual license or apply for your own [here](https://surfer.nmr.mgh.harvard.edu/registration.html).



