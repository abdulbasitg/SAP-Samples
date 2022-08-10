# Managed Approuter

## Overview

There are two options to use the Application Router in SAP BTP:
- Managed Application Router
- Standalone Application Router

This sample demonstrates the scenario to use the Managed Application Router via Kyma runtime. 

## Scenario

In this sample, we are deploying two Fiori applications using the npm module html5-app-deployer provided by SAP. deployment.yaml file has configurations for all services and bindings required to run the scenario. 

We have the following file structure in the repository: 
```shell script
.\
├── README.md
├── app
│   ├── Dockerfile
│   ├── package.json
│   └── resources
│       ├── app1
│       │   ├── manifest.json
│       │   └── xs-app.json
│       │   └── ... 
│       ├── app2
│           ├── manifest.json
│           └── xs-app.json
│           └── ... 
└── deployment.yaml
```

Let's review the important files and understand their roles in the scenario:

- **deployment.yaml** This file contains all required services and bindings required to run the scenario.
- **Dockerfile** This is required to build the docker image that will be used to deploy HTML5 applications to SAP BTP HTML5 Application Repository. Fiori applications will be copied into docker image and they will be deployed with **html5-app-deployer** npm module provided by SAP.
- **package.json** This is the basic package.json file that will be used to install required node modules and run the HTML5 deployment process. 
- **application folders** Fiori applications that will be deployed to the HTML5 Application Repository should be included in a separate folders in /app/resources folders. In addition to the Fiori application resources, the following files must be included with the Fiori application's root folder:
  - **xs-app.json** This file contains the configuration information used by the application router.
  - **manifest.json** In addition to the configurations of the Fiori applications, it should contaion the required information for Fiori application to run in Launchpad Service on BTP.

When you deploy your apps into HTML5 Application Repository, they are classified with SAP_CLOUD_SERVICE environment variable provided in Deployment part of the deployment configuration. It is also important to use the same value in the "sap.cloud.service" value defined in manifest.json file. In this repository it is defined as "ag.samples".  

I've added a shell script to make it easier to deploy, delete or reset the resources in the Kyma runtime. It helps when you might need to deploy or delete reserources several times during the development. It is only available for Mac/Linux but it is easy to create Windows version too. 

```shell script
./run.sh <deploy|delete|reset|dockerbuild|dockerpush>
```
- **deploy** Applies the deployment configuration to the Kyma Runtime
- **delete** Deletes all the resounrces: deployments, services and bindings in the Kyma Runtime 
- **reset** deletes and re-deploys all the resources: deployments, services and bindings in the Kyma Runtime.
- **dockerbuild** Builds docker image using DOCKERFILE 
- **dockerpush** Pushes Docker image to the repository

There are default variables defined at the top of the run.sh script to make it easier to configure the sample files according to your runtime setttings. 

