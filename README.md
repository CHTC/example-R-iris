# Iris Analysis in CHTC

This repository contains a example job submission to CHTC's High Throughput Computing (HTC) system that performs a short analysis of the built-in iris dataset from R. It uses a job design and setup as written up in this [how-to guide](http://chtc.cs.wisc.edu/r-jobs.shtml)

## Requirements

To run this example, you will need access to an HTCondor scheduled system, likely with a newish version of HTCondor, and where the resources available to you are using CentOS 7 (or a Linux distribution from the same Red Hat family). 

## Included

Files needed for the analysis: 
- `summarize.R`: the R script
- `iris_data.csv`: the input data file
- `tidyverse.tar.gz`: a zipped copy of the tidyverse packages, built against R-3.5.1 on CentOS 7
- a copy of R, v3.5.1, this example is designed to use the copy hosted on CHTC's Squid web cache

Files needed to submit the job: 
- `run_R.sh`: a shell script that runs the R analysis
- `job.submit`: an HTCondor submit file

## Instructions

1. Log into the HTCondor submit server you can access. 
    * On Windows: use [Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
    * On Mac/Linux: use a terminal and `ssh`: `ssh username@servername`
2. Clone this repository and move into the the directory with files
```
git clone https://github.com/CHTC/example-R-iris
cd example-R-iris
```
3. We've provided most of the files, but we still need to provide information to the submit file (`job.submit`) about the job's executable and input files. The input files should include all the files listed above (`summarize.R`, `iris_data.csv`, `tidyverse.tar.gz`) and a link to CHTC's copy of R, which can be referenced with the link `http://proxy.chtc.wisc.edu/SQUID/chtc/R351.tar.gz`. The `run_R.sh` file should be the job's "executable". 
4. The `run_R.sh` file has the command to run R, but will need additional commands to set up an R installation as part of the job. Modify it based on the information provided in [this section of the CHTC R jobs guide](http://chtc.cs.wisc.edu/r-jobs.shtml#script). Note that our packages are saved in a file called `tidyverse.tar.gz` and the folder inside is called `tidy`. 
5. Once you've made the changes to the submission, try submitting the job using:
```
condor_submit job.submit
```

## What's Missing

For real jobs, you may have to create your own `tar.gz` file with the packages you need and submit more than one job at once. 
