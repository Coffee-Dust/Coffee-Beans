DEMO_NAME="coffee_beans_rails"

echo "Running coffeedust.io demo install script for"
echo $DEMO_NAME
echo "----------------------"

if [ ! -d "../$DEMO_NAME" ];
then
  echo "ERROR: You are not in the correct directory"
else
  bundler install
  rails credentials:edit
  rake db:migrate RAILS_ENV=test
  yarn
echo "$DEMO_NAME installed!"
fi
