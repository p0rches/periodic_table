#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"
if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  INPUT=$1
  # if input is atomic_number
  # regex: checks if the input is an integer of any length
  if [[ $INPUT =~ ^[0-9]+$ ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $INPUT")
    if [[ -z $ELEMENT_INFO ]]
    then
      echo I could not find that element in the database.
    else
      echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  fi
  # if input is symbol
  # regex: checks if the input is a string of one or two characters
  if [[ $INPUT =~ ^[a-zA-Z]{1,2}$ ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$INPUT'")
    if [[ -z $ELEMENT_INFO ]]
    then
      echo I could not find that element in the database.
    else
      echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  fi
  # if input is name
  # regex: checks if the input is a string of three or more characters
  if [[ $INPUT =~ ^[a-zA-Z]{3,}$ ]]
  then
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) WHERE name = '$INPUT'")
    if [[ -z $ELEMENT_INFO ]]
    then
      echo I could not find that element in the database.
    else
      echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  fi
fi