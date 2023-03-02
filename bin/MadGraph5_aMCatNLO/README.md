
# How to produce a gridpack under singularity in lxplus

1. open `lxplus`
2. `git clone https://github.com/cms-sw/genproductions.git`
3. `git checkout origin/mg242legacy`
    1. if you are working under some branch different from master, please copy [`submit_condor_gridpack_generation.sh`](https://github.com/cms-sw/genproductions/blob/master/bin/MadGraph5_aMCatNLO/submit_condor_gridpack_generation.sh), `Utilities/*` scripts from master branch to your desired branch, as other branches may have bugged scripts.   
4. Submit via condor 
    1. as a first thing is better to check is condor submission works for current centos7 release, using default commands found here: [https://twiki.cern.ch/twiki/bin/viewauth/CMS/QuickGuideMadGraph5aMCatNLO#Monitoring_the_status_of_your_gr](https://twiki.cern.ch/twiki/bin/viewauth/CMS/QuickGuideMadGraph5aMCatNLO#Monitoring_the_status_of_your_gr) 
    `./submit_condor_gridpack_generation.sh <name of process card without _proc_card.dat> <folder containing cards relative to current location>` 
    as it can be that the python API is not available for condor in the current machine we are running on. 
    If that's the case and errors are encountered, copy the `submit_condor_gridpack_generation.sh`file and Utilities folder from master branch, where this issue has been solved ([https://hypernews.cern.ch/HyperNews/CMS/get/generators/5068/3/1/1.html](https://hypernews.cern.ch/HyperNews/CMS/get/generators/5068/3/1/1.html) ). 
    2. Use the following codes in "slc6_condor" folder to have submission working for singularity, and run it like 
    `condor_submit condor_gridpack.sub`


5. Produce the gridpack locally:
    1. `cmssw-env --cmsos slc6` 
    2. follow default instructions [https://twiki.cern.ch/twiki/bin/viewauth/CMS/QuickGuideMadGraph5aMCatNLO#Quick_tutorial_on_how_to_produce](https://twiki.cern.ch/twiki/bin/viewauth/CMS/QuickGuideMadGraph5aMCatNLO#Quick_tutorial_on_how_to_produce)

