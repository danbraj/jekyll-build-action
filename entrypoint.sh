#!/bin/sh -l

echo "Hello, $1"
bundle --version
gem install bundler -v 2.0.1
echo "> Bundle installation completed"
bundle install
echo "> Project installation completed"
bundle exec jekyll build
echo "> Build completed"

echo "Test 1: ${GITHUB_TOKEN}"
echo "Test 2: $GITHUB_TOKEN"

remote_repo="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

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
