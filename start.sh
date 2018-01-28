#vagrant init hashicorp/precise64
rm -rf data
rm -rf output
mkdir data
mkdir data/output
cp Scripts/backup Vagrantfile
cp -R Scripts/* data/
sleep 2
vagrant up
sleep 2
echo "Final Result"
cat  data/output/*
