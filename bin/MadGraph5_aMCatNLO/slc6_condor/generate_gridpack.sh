#!/bin/bash

cat <<'EndOfFile' > execute.sh
#!/bin/bash

source /cvmfs/cms.cern.ch/cmsset_default.sh

cd /afs/cern.ch/work/m/mpresill/genproductions/bin/MadGraph5_aMCatNLO
# clean up gridpack
rm -rf aQGC_ZlepZhadJJ_EWK_LO_SM_mjj100_pTj10*
#generate gridpack
./gridpack_generation.sh aQGC_ZlepZhadJJ_EWK_LO_SM_mjj100_pTj10 cards/production/2017/13TeV/VBS/aQGC_VVjj_semileptonic/aQGC_ZlepZhadJJ_EWK_LO_SM_mjj100_pTj10
# copy to final destination 

EndOfFile

# Make file executable
chmod +x execute.sh 

export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
singularity run -B /afs -B /cvmfs -B /usr/libexec/condor -B /pool --no-home docker://cmssw/slc6:latest $(echo $(pwd)/execute.sh)

rm execute.sh 
