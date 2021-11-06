counter=0
max=10

while [ $counter -lt $max ]
do
  echo $counter
  (( counter++ ))
done