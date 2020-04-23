# stop script on error
set -e

# Check to see if root CA file exists, download if not
if [ ! -f ./root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from AWS...\n"
  curl https://www.amazontrust.com/repository/AmazonRootCA1.pem > root-CA.crt
fi

# install AWS Device SDK for NodeJS if not already installed
if ! node -e "require('aws-iot-device-sdk')" &> /dev/null; then
  printf "\nInstalling AWS SDK...\n"
  npm install aws-iot-device-sdk
fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
node node_modules/aws-iot-device-sdk/examples/device-example.js --host-name=aczelvq5m2cch-ats.iot.us-west-2.amazonaws.com --private-key=Armadillo-IoT.private.key --client-certificate=Armadillo-IoT.cert.pem --ca-certificate=root-CA.crt --client-id=sdk-nodejs-6b09df7f-a592-4576-ad30-ae96c2c73ee0
