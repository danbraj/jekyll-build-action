#!/bin/sh -l

bundle --version
echo "Hello, $1"
bundle install
echo "> Installation completed"
bundle exec jekyll build
echo "> Build completed"

remote_repo="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

cd _site
git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add .
git commit -m 'Build website from Action'
git push --force $remote_repo master:${DEPLOY_BRANCH}
echo "> Deployment completed"
rm -fr .git
cd ..

echo "> Finished"
