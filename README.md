# common-lamp
<h2>Common Linux, Apache, MySQL and PHP Environment Setup for Docker</h2>

<h3>What is it?</h3>

<p>This is a common/general purpose docker image and docker-compose to gather as much PHP libraries and Apache as possible.</p>

<h3>Why are you doing it?</h3>

<p>I would like to make a "replacable" docker image/machine that has less dependency as possible.  So that wheneve there is a new project, I can simply download and setup a new image and start building website project right away, without spending another half day or even 1 - 2 hours just to setup and config an environment.</p>

<h3>What are inside?</h3>

<p>This includes:</p>

<ul>
	<li>Linux (Ubuntu 16.04) </li>
	<li>Apache 2.4 (Use apt-get install apache instead of using official image)</li>
	<li>PHP 7 (Use apt-get to download PHP instead of using official image)</li>
	<li>MySQL (From official MySQL docker image: mysql:latest)</li>
</ul>

<h2>Notes on Apache/PHP</h2>

<ul>
	<li>I am using Ubuntu 16.04, and the Apache/PHP in Ubuntu official repo.  Because it is simpler to install/config/use, than using "official" image.</li>
	<li>The main obstacle of NOT using official PHP docker image is that, if I want to install additional PHP modules, I need to use their custom commands instead of normal apt-get.  To me, using Ubuntu official apt-get command and download repo from them is much easier and safer.</li>
	<li>Please read my Dockerfile, it is much simpler than before, and give you a general idea on what I did.</li>
	<li>It is using latest PHP 7 and latest Apache</li>
	<li>Web file directory in Apache container is /var/www/html</li>
	<li>Web files are stored OUTSIDE the container.  By default (docker-compose.yml), you will have a html directory that saved all your files (Directory structure see below).</li>
	<li>Docker host (the computer which you run "docker" command) opens port 80.</li>
	<li>Apache container exposes port 80.</li>
	<li>Visitor website traffic coming from docker host will be forward to apache container (80:80)</li>
	<li>The name in YML is called "web", and it links to "db", which is the database (See below).</li>
	<li>You may also see that I install Redis.  And yes, my plan is to use Redis to speed up the loading time.  One of my to-do item is to integrate Redis into this project.</li>
</ul>

<h2>Notes on MySQL</h2>

<ul>
	<li>It is based on official MySQL docker image (https://hub.docker.com/_/mysql/).  I am using tag "latest".</li>
	<li>Web files are stored OUTSIDE the container.  By default (docker-compose.yml), data is saved under "mysql_data" (Directory structure see below).</li>
	<li>Docker host (the computer which you run "docker" command) opens port 3306.</li>
	<li>MySQL container exposes port 3306.</li>
	<li>DB connection traffic coming from docker host will be forward to apache container (3306:3306)</li>
	<li>The name in YML is called "db", and it is linked from "web" (See above).</li>
</ul>

<h2>Directory Structure</h2>

<p>Below is the exact file name inside a directory. () is comment.</p>

<p>
- common-lamp<br/>
---- docker-compose.yml<br/>
---- Dockerfile<br/>
---- html (will be created when you run "docker-compose up -d")<br/>
---- mysql_data (will be created when you run "docker-compose up -d")<br/>
</p>

<h2>Assumptions</h2>

<ul>
	<li>The purpose of this Git is to create the envirnoment as soon as possible.</li>
	<li>Why not XAMPP?  Well you can.  It is your choice.  :D  But it seems docker provides much more potential (http://www.sitepoint.com/re-introducing-vagrant-right-way-start-php/).  This article is talking about Vagrant, but same idea still applies, I think.</li>
	<li>I put all website files and database files OUTSIDE the container, make the container a replaceable "machine".</li>
	<li>One website project, one common-lamp, which means one set of common-lamp.</li>
	<li>One website project means: one web server and one database server.  In other words, <strong>no cluster</strong>.</li>
</ul>

<h2>Known issue/TODO:</h2>

<ul>
	<li>I realise that the database expose may actually be unnecessary and will have potential security problem.</li>
	<li>Add custom httpd.conf php.ini and my.cnf config files.</li>
	<li>Use Redis to speedup loading website.  Yes you are right, I am using Wordpress on most of my project at this moment.</li>
</ul>

<h2>My comments:</h2>

<p>I know, the common/best practise is to limit the available components as many as possible to prevent potential library conflicts and unnecessary performance punishment.  However, the concept here is to setup an contain-everything machine FIRST, and then disable necessary libraries based on your requirements.</p>

<p>Based on the above concept, it is surprising to know that it is difficult to find such thing.  So I decided to take the first step to create that.</p>

<p>I am not perfect, and neither is my Git/code/program.  Therefore this docker-compose.yml and Dockerfile will be continuously optimized/re-structure so that it can benefit me, and you also.</p>

<p>Any suggestions/recommendations/comments are welcomed!</p>

<p>Happy dockering and developing</p>

<p>Talk soon</p>

<p>Ellery</p>
