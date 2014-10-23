#!/bin/sh
#!/bin/bash

url=http://repository.codehaus.org/org/codehaus/sonar-plugins

for x in javascript/sonar-javascript-plugin/1.6/sonar-javascript-plugin-1.6.jar \
    python/sonar-python-plugin/1.3/sonar-python-plugin-1.3.jar \
    scm-activity/sonar-scm-activity-plugin/1.8/sonar-scm-activity-plugin-1.8.jar \
    sonar-artifact-size-plugin/0.3/sonar-artifact-size-plugin-0.3.jar \
    sonar-branding-plugin/0.5/sonar-branding-plugin-0.5.jar \
    sonar-build-breaker-plugin/1.1/sonar-build-breaker-plugin-1.1.jar \
    sonar-build-stability-plugin/1.2/sonar-build-stability-plugin-1.2.jar \
    sonar-generic-coverage-plugin/1.1/sonar-generic-coverage-plugin-1.1.jar \
    sonar-motion-chart-plugin/1.7/sonar-motion-chart-plugin-1.7.jar \
    sonar-groovy-plugin/1.0.1/sonar-groovy-plugin-1.0.1.jar \
    sonar-timeline-plugin/1.4/sonar-timeline-plugin-1.4.jar \
    sonar-useless-code-tracker-plugin/1.0/sonar-useless-code-tracker-plugin-1.0.jar; do
    wget "$url/$x"
done
