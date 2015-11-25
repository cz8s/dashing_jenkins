In theory, this should be enough:

* git clone https://github.com/cz8s/dashing_jenkins.git
* cd dashing_jenkins
* bundle install
* change the url in jobs/ccmenu.rb
* export JENKINS_USER='whatever'
* export JENKINS_PASS='whatever'
* dashing start

Check out http://shopify.github.com/dashing for more information.
