#!/usr/bin/groovy
@Library(['com.optum.jenkins.pipelines.templates.terraform', 'com.optum.jenkins.pipeline.library']) _

pipeline {
  // agent none
   agent any
  environment {
    AZURE_CREDENTIALS_ID = 'PHA-ServicePrincipal'
    DEPLOY_BRANCH = 'web_portal'
    AZURECLI_VERSION = '2.0.74'
    TERRAFORM_VERSION = '0.12'
  }
  options {
    disableConcurrentBuilds()
  }
  stages {
     stage('Unit Tests') {
           agent {
                label 'docker-nodejs-slave'
            }  
          steps {
                sh 'npm run test'
            }
        }
    
   /* stage('Fortify Scan') {
      agent {
        label 'docker-nodejs-slave'
      }
      steps {
        glFortifyScan fortifyBuildName: "UKPopHealth_UHGWM110-022675",                   
                scarCredentialsId: "pha_migration",
                scarProjectVersion:"20909",
                //scarProjectVersion:"111", //fail build
                scarProjectName:"UKPopHealth_UHGWM110-022675",
                criticalThreshold: 25,
                highThreshold: 50,
                mediumThreshold: 100,
                lowThreshold: 150,                          
                fortifyTranslateExclusions:"-exclude 'terraform_module/*.tf' -exclude 'terraform_module/*.sh'" ,
                uploadToScar: false         
      }            
      post {          
        failure {                                      
          echo 'Jenkins Build failure!'            
          emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
          recipientProviders: [developers(), requestor()],
          subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
          to: 'nagesh_bandaru@optum.com'
        }
        success {                                      
          echo 'Jenkins Build success!'            
          emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
          recipientProviders: [requestor()],
          subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
          to: 'nagesh_bandaru@optum.com'
        }
      }
    }
 
    
     stage ('Sonar Scan') {
      agent {
        label 'docker-nodejs-slave'
      }
      steps {
        glSonarScan sonarHostUrl:"https://sonar.optum.com",
        mainBranchName:"wdc_demo",
        sources:"webdataconnector"                
      }
      post {          
        failure {                                      
          echo 'Jenkins Build failure!'            
          emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
          recipientProviders: [developers(), requestor()],
          subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
          to: 'maniteja.namburi@optum.com'
        }
        success {                                      
          echo 'Jenkins Build success!'            
          emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
          recipientProviders: [requestor()],
          subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
          to: 'maniteja.namburi@optum.com'
        }
      } 
    } */
    
    
    stage ('Prepare Terraform Environment') {
      agent {
        label 'docker-maven-slave'
        //'docker-azure-agent'
      }
      environment {
        //Set all these values for each environment
        VARIABLES_FILE = 'demo.tfvars'
        TF_BACKEND_RG = 'rg-pha-demo'
        TF_BACKEND_ACCOUNT = 'dlsstatedemo'
        TF_BACKEND_LOCATION = 'centralus'
        TF_BACKEND_CONTAINER = 'wdcstates'
        TF_BACKEND_KEY = ' wdc.tfstate'
      }
      stages {
       /* stage('Terraform Init') {
          steps {
              glAzureLogin(env.AZURE_CREDENTIALS_ID) {
                glTerraformInit(
                  azureInit: true,
                )
            }
          }
        } */
  //      stage('Terraform Plan') {
  //        steps {
  //            glAzureLogin(env.AZURE_CREDENTIALS_ID) {
  //              glTerraformPlan(                                                                        
  //                additionalFlags: [
  //                  ('var-file'): env.VARIABLES_FILE,
  //                  out: 'plan.tfplan',
  //                ]
  //              )
  //            }
  //            stash name: 'tfenv', includes: ".terraform/**/*, plan.tfplan"
   //         }
   //       }
        
   //   }
  //  }
    
 /*   stage('Apply Terraform Plan') {
      agent {
        label 'docker-maven-slave'
      }
      steps {
        glAzureLogin(env.AZURE_CREDENTIALS_ID) {
          unstash name: 'tfenv'
          glTerraformApply(
            planFile: 'plan.tfplan'
          )
        }
      }
    } */

/*  stage('Build and Deploy Docker Image to jfrog') {
           
            agent {
                label 'docker-nodejs-slave'
            }
            steps {
     glDockerImageBuildPush  tag:"docker.repo1.uhc.com/pha_cloud_transformation/webdataconnector:${BUILD_NUMBER}",
                                dockerCredentialsId: "ukbipha",
                                dockerHost: 'docker.repo1.uhc.com'
             
            }
       } */
    
        
 
  }
}

  




  
