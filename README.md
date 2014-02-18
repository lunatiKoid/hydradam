# Setting up a local development copy

```
git clone ...
cd hydradam
cp config/database.yml.sample config/database.yml   # setup local config files with dev environment defaults
cp config/redis.yml.sample config/redis.yml
cp config/solr.yml.sample config/solr.yml
cp config/fedora.yml.sample config/fedora.yml
bundle install
```
It's easiest to use hydra-jetty to get fedora and solr running in your development environment, get a copy from github and update your application config files:

```
rake jetty:unzip
rake jetty:config
```

Make sure your database configuration is up-to-date:
```
rake db:migrate
```

Set up your application secret token.
```
cp config/initializers/secret_token.rb.sample config/initializers/secret_token.rb
```
... then replace the sample secret token in that file with one of your own. You can use `rake secret` to generate a token for you.

Set up a devise secret token.
```
cp config/initializers/devise.rb.sample config/initializers/devise.rb
```
... then replace the sample secret token in that file with one of your own. You can use `rake secret` to generate a token for you.
 
You also need ffmpeg installed with some extra codecs enabled.  See the [Sufia README file](https://github.com/projecthydra/sufia/blob/master/README.md#if-you-want-to-enable-transcoding-of-video-instal-ffmpeg-version-10) for instructions.

## Import Authority files

### Subjects

Go to http://id.loc.gov/download/ and find the "LC Subject Headings (SKOS/RDF only)" file.
Download the .nt version of that file.
Uncompress the file and move it to ```/tmp/subjects-skos.nt```.

Run the rake task to import it:
```bash
rake hydradam:harvest:lc_subjects
```

### Languages

Download and unzip this file: http://www.lexvo.org/resources/lexvo_2012-03-04.rdf.gz
Move the file to ```/tmp/lexvo_2012-03-04.rdf```

Run the rake task to import it:
```bash
rake hydradam:harvest:lexvo_languages

=======
## Importing metadata templates

```bash
# Usage:
./script/import_metadata <file> <user_id>
  
# Example:
./script/import_metadata spec/fixtures/import/metadata/broadway_or_bust.pbcore.xml archivist1@example.com
```

## Start workers
```
QUEUE=* rake environment resque:work
```

# Running tests


If you have jetty running, run 

```
rake spec
```

To run the whole test suite, including spinning jetty up & down, loading fedora fixtures, etc. 
```
rake ci
```
