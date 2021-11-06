greeting () {
  echo Hello $1
}

greeting 'Peter' # outputs 'Hello Peter'

greeting_two () {
  echo "Hello $1"
  echo "Hello $2"
}

greeting_two 'Paul' 'John'