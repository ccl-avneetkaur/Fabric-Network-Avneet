#!/bin/bash

function createIndia() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/india.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/india.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-india --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-india.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-india.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-india.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-india.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/india.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-india --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-india --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-india --id.name indiaadmin --id.secret indiaadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-india -M ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/msp --csr.hosts peer0.india.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/india.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-india -M ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls --enrollment.profile tls --csr.hosts peer0.india.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/india.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/india.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/india.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/india.example.com/tlsca/tlsca.india.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/india.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/india.example.com/peers/peer0.india.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/india.example.com/ca/ca.india.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-india -M ${PWD}/organizations/peerOrganizations/india.example.com/users/User1@india.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/india.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/india.example.com/users/User1@india.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://indiaadmin:indiaadminpw@localhost:7054 --caname ca-india -M ${PWD}/organizations/peerOrganizations/india.example.com/users/Admin@india.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/india/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/india.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/india.example.com/users/Admin@india.example.com/msp/config.yaml
}

function createAustralia() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/australia.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/australia.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-australia --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-australia.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-australia.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-australia.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-australia.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/australia.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-australia --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-australia --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-australia --id.name australiaadmin --id.secret australiaadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-australia -M ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/msp --csr.hosts peer0.australia.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/australia.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-australia -M ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls --enrollment.profile tls --csr.hosts peer0.australia.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/australia.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/australia.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/australia.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/australia.example.com/tlsca/tlsca.australia.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/australia.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/australia.example.com/peers/peer0.australia.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/australia.example.com/ca/ca.australia.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-australia -M ${PWD}/organizations/peerOrganizations/australia.example.com/users/User1@australia.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/australia.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/australia.example.com/users/User1@australia.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://australiaadmin:australiaadminpw@localhost:8054 --caname ca-australia -M ${PWD}/organizations/peerOrganizations/australia.example.com/users/Admin@australia.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/australia/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/australia.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/australia.example.com/users/Admin@australia.example.com/msp/config.yaml
}

function createOrderer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/example.com

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml

  infoln "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  infoln "Generating the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  infoln "Generating the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml
}
