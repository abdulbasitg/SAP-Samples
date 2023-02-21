#cf delete-route cfapps.eu20.hana.ondemand.com --hostname cfbasics1
#cf delete-route cfapps.eu20.hana.ondemand.com --hostname cfbasics2
cf delete cfbasics-static -fr
cf delete cfbasics-with-destination -fr
cf delete-service cfbasics-xsuaa -f
cf delete-service cfbasics-destination -f