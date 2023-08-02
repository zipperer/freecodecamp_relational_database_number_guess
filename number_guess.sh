#!/bin/bash

echo "Enter your username:"
read INPUT_USERNAME
#todo: confirm $INPUT_USERNAME will fit in column in database, i.e. VARCHAR(22)

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT_USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $INPUT_USERNAME! It looks like this is your first time here."
  INSERT_RESULT=$($PSQL "INSERT INTO users (username) VALUES ('$INPUT_USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$INPUT_USERNAME'")
else
  USER_INFO_GAMES_PLAYED=$($PSQL "SELECT COUNT(game_id) FROM games WHERE user_id = '$USER_ID'")
  # currently assuming user has finished all previous games
  USER_INFO_BEST_GAME=$($PSQL "SELECT MIN(count_guesses_so_far) FROM games WHERE user_id = '$USER_ID'")
  echo "Welcome back, $INPUT_USERNAME! You have played $USER_INFO_GAMES_PLAYED games, and your best game took $USER_INFO_BEST_GAME guesses."
fi

MAX_RANDOM_NUMBER=1000
RANDOM_NUMBER_BETWEEN_0_AND_32767=$RANDOM
RANDOM_NUMBER_BETWEEN_0_AND_ONE_LESS_THAN_MAX_RANDOM_NUMBER=$(( RANDOM_NUMBER_BETWEEN_0_AND_32767 % MAX_RANDOM_NUMBER ))
RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER=$(( RANDOM_NUMBER_BETWEEN_0_AND_ONE_LESS_THAN_MAX_RANDOM_NUMBER + 1 ))

MAKE_NEW_GAME_RESULT=$($PSQL "INSERT INTO games (user_id, secret_number) VALUES ($USER_ID, $RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER)")
CURRENT_GAME_ID=$($PSQL "SELECT MAX(game_id) FROM games WHERE user_id = '$USER_ID'")

echo "Guess the secret number between 1 and 1000:"
USER_GUESSED_CORRECTLY=false
USER_COUNT_GUESSES=0
while [[ ! $USER_GUESSED_CORRECTLY == 'true' ]]
do
  read USER_GUESS
  USER_COUNT_GUESSES=$(( USER_COUNT_GUESSES + 1 ))
  if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    if [[ $USER_GUESS -gt $RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER ]]
    then
      echo "It's lower than that, guess again:"
    else
      if [[ $USER_GUESS -lt $RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        if [[ $USER_GUESS -eq $RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER ]]
        then
          USER_GUESSED_CORRECTLY=true
          echo "You guessed it in $USER_COUNT_GUESSES tries. The secret number was $RANDOM_NUMBER_BETWEEN_1_AND_MAX_RANDOM_NUMBER. Nice job!"
        fi
      fi
    fi
  fi
done
UPDATE_RESULT=$($PSQL "UPDATE games SET count_guesses_so_far = $USER_COUNT_GUESSES WHERE game_id = $CURRENT_GAME_ID")
