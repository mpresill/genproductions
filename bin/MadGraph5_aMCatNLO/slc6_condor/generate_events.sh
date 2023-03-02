#!/bin/bash

cd ${_CONDOR_SCRATCH_DIR}
cat <<'EndOfFile' > execute.sh
#!/bin/bash

pwd -P 

source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc481
if [ -r CMSSW_7_1_25_patch1/src ] ; then
  echo release CMSSW_7_1_25_patch1 already exists
else
  scram p CMSSW CMSSW_7_1_25_patch1
fi
cd CMSSW_7_1_25_patch1/src
eval `scram runtime -sh`


# Download fragment from McM
curl -s -k https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/B2G-RunIISummer15wmLHEGS-00261 --retry 3 --create-dirs -o Configuration/GenProduction/python/B2G-RunIISummer15wmLHEGS-00261-fragment.py

scram b
cd ../..

EVENTS=10

# Random seed between 1 and 100 for externalLHEProducer
SEED=23123 


# cmsDriver command
cmsDriver.py Configuration/GenProduction/python/B2G-RunIISummer15wmLHEGS-00261-fragment.py --python_filename B2G-RunIISummer15wmLHEGS-00261_1_cfg.py --eventcontent RAWSIM,LHE --customise SLHCUpgradeSimulations/Configuration/postLS1Customs.customisePostLS1,Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM,LHE --fileout file:B2G-RunIISummer15wmLHEGS-00261.root --conditions MCRUN2_71_V1::All --beamspot Realistic50ns13TeVCollision --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${SEED})" --step LHE,GEN,SIM --magField 38T_PostLS1 --mc -n $EVENTS 

cp B2G-RunIISummer15wmLHEGS-00261.root /afs/cern.ch/user/g/grohsjea/public/slc6_condor/. 

EndOfFile

# Make file executable
chmod +x execute.sh

pwd -P 

export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
pwd -P 
echo $SINGULARITY_CACHEDIR
singularity run -B /afs -B /cvmfs -B /usr/libexec/condor -B /pool --no-home docker://cmssw/slc6:latest $(echo $(pwd)/execute.sh)


