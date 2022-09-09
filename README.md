# TestCI2
For Self Hosted to run:
1) We need a EC2 host
2) Run all these steps 
  -----------------------    
      Download
# Create a folder
$ mkdir actions-runner && cd actions-runner# Download the latest runner package
$ curl -o actions-runner-linux-x64-2.296.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz# Optional: Validate the hash
$ echo "34a8f34956cdacd2156d4c658cce8dd54c5aef316a16bbbc95eb3ca4fd76429a  actions-runner-linux-x64-2.296.2.tar.gz" | shasum -a 256 -c# Extract the installer
$ tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz
Configure
# Create the runner and start the configuration experience
$ ./config.sh --url https://github.com/Chandruhere4u/TestCI2 --token ADAAKFIBUDJYUL25BPYP4Q3DDNJII# Last step, run it!
$ ./run.sh
Using your self-hosted runner
# Use this YAML in your workflow file for each job
runs-on: self-hosted

-----------------------
3) Keep the runner running and have the self hosted.
4) Have the IAM with proper permissions to assume role, create S3
5) If GIT asks access key and id, then its your own connectivity details. But we can try woth Assume role details as well.
