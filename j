#!/usr/bin/env groovy

@Library("com.optum.jenkins.pipeline.library@master") _

pipeline {
  agent none
  environment {
    AZURE_CREDENTIALS_ID = 'dqaf-azure-nonprod-jenkins'
    DEPLOY_BRANCH = 'master'
    AZURECLI_VERSION = '2.0.74'
    TERRAFORM_VERSION = '0.12'
    HELM_VERSION      = '3.1.2'
  }
  options {
    disableConcurrentBuilds()
  }
  stages {
    stage ('Prepare Terraform Environment') {
      agent {
        label 'docker-azure-agent'
      }
      environment {
        //Set all these values for each environment
        VARIABLES_FILE = 'terraform.tfvars'
        TF_BACKEND_RG = 'terraform-rg'
        TF_BACKEND_ACCOUNT = 'dqafrulesnonprodtfbk'
        TF_BACKEND_LOCATION = 'centralus'
        TF_BACKEND_CONTAINER = 'tfstate'
        TF_BACKEND_KEY = 'terraform.tfstate'
      }
      stages {
        stage('Terraform Init') {
          steps {
            glAzureLogin(env.AZURE_CREDENTIALS_ID) {
              glTerraformInit(
                azureInit: true,
              )
            }
          }
        }
        stage('Terraform Plan') {
          steps {
            withCredentials([usernamePassword(credentialsId: 'nonprod-aks-sp-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            //add after Jenkins is upgraded
            //ansiColor('xterm') {
              glAzureLogin(env.AZURE_CREDENTIALS_ID) {
                //No helm release yet for this project
                sh "git clone https://github.com/kubernetes-sigs/secrets-store-csi-driver"
                glTerraformPlan(
                  additionalFlags: [
                    ('var-file'): env.VARIABLES_FILE,
                    out: 'plan.tfplan',
                  ]
                )
              }
              stash name: 'tfenv', includes: ".terraform/**/*, plan.tfplan"
            //}
            }
          }
        }
      }
    }
    stage('Validate Terraform Plan') {
      agent none
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        timeout(time: 30, unit: 'MINUTES') {
          input(message: 'Apply this terraform plan?')
        }
      }
    }
    stage('Apply Terraform Plan') {
      agent {
        label 'docker-azure-agent'
      }
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        glAzureLogin(env.AZURE_CREDENTIALS_ID) {
          //ansiColor('xterm') {
            unstash name: 'tfenv'
            sh "git clone https://github.com/kubernetes-sigs/secrets-store-csi-driver"
            glTerraformApply(
              planFile: 'plan.tfplan'
            )
          //}
        }
      }
    }
    stage ('Prepare Terraform Environment - AKS') {
      agent {
        label 'docker-azure-agent'
      }
      environment {
        //Set all these values for each environment
        VARIABLES_FILE = 'terraform.tfvars'
        TF_BACKEND_RG = 'terraform-rg'
        TF_BACKEND_ACCOUNT = 'dqafrulesnonprodtfbk'
        TF_BACKEND_LOCATION = 'centralus'
        TF_BACKEND_CONTAINER = 'tfstate'
        TF_BACKEND_KEY = 'terraform-aks.tfstate'
        AKS_RG = 'dqaas_nonprod'
        AKS_NAME = 'dqaas-aks'
      }
      stages {
        stage('Terraform Init - AKS') {
          steps {
            dir('kubernetes') {
              glAzureLogin([
                credentialsId: env.AZURE_CREDENTIALS_ID,
                aks: [resourceGroup: env.AKS_RG, clusterName: env.AKS_NAME]
              ]) {
                glTerraformInit(
                  azureInit: true,
                )
              }
            }
          }
        }
        stage('Terraform Plan - AKS') {
          steps {
            dir('kubernetes') {
              withCredentials([usernamePassword(credentialsId: 'nonprod-aks-sp-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
              //add after Jenkins is upgraded
              //ansiColor('xterm') {
                glAzureLogin([
                  credentialsId: env.AZURE_CREDENTIALS_ID,
                  aks: ['resourceGroup': env.AKS_RG, name: env.AKS_NAME]
                ]) {
                  //No helm release yet for this project
                  sh "git clone https://github.com/kubernetes-sigs/secrets-store-csi-driver"
                  glTerraformPlan(
                    additionalFlags: [
                      ('var-file'): env.VARIABLES_FILE,
                      out: 'plan.tfplan',
                    ]
                  )
                }
                stash name: 'tfenv-aks', includes: ".terraform/**/*, plan.tfplan"
            //}
              }
            }
          }
        }
      }
    }
    stage('Validate Terraform Plan - AKS') {
      agent none
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        timeout(time: 30, unit: 'MINUTES') {
          input(message: 'Apply this terraform plan?')
        }
      }
    }
    stage('Apply Terraform Plan - AKS') {
      agent {
        label 'docker-azure-agent'
      }
      environment {
        AKS_RG = 'dqaas_nonprod'
        AKS_NAME = 'dqaas-aks'
      }
      when {
        branch env.DEPLOY_BRANCH
      }
      steps {
        dir('kubernetes') {
          glAzureLogin([
            credentialsId: env.AZURE_CREDENTIALS_ID,
            aks: [resourceGroup: env.AKS_RG, clusterName: env.AKS_NAME]
          ]) {
            //ansiColor('xterm') {
            sh """
            . /tools/azurecli/mixin.sh
            az aks get-credentials -g ${env.AKS_RG} -n ${env.AKS_NAME}
            """
            unstash name: 'tfenv-aks'
            sh "git clone https://github.com/kubernetes-sigs/secrets-store-csi-driver"
            glTerraformApply(
              planFile: 'plan.tfplan'
            )
            //}
          }
        }
      }
    }
  }
}
