#!/bin/bash -x
declare -A coinDict1
declare -A coinDict2
declare -A coinDict3
declare -A coinArray1
declare -A coinArray2
declare -A coinArray3
largest=0
max=""
function percentage1()
{
	local v=$1
	coinPercent1=$((${coinDict1[$v]}*100/$no_of_flips))
	coinArray1[$v]=$coinPercent1
	if [[ $coinPercent1>$largest ]]
	then
		largest=$coinPercent1
		echo $v
	fi
}

function percentage2()
{
	local v=$1
	coinPercent2=$((${coinDict2[$v]}*100/$no_of_flips))
	coinArray2[$v]=$coinPercent2
	if [[ $coinPercent2>$largest ]]
	then
		largest=$coinPercent2
		echo $v
	fi
}

function percentage3()
{
	local v=$1
	coinPercent3=$((${coinDict3[$v]}*100/$no_of_flips))
	coinArray3[$v]=$coinPercent3
	if [[ $coinPercent3>$largest ]]
	then
		largest=$coinPercent3
		echo $v
	fi
}

function flipSimulator()
{
	local coins=$1
	local flips=$2
	for (( i=1; i<=$flips; i++ ))
	do
		coinFlip=""
		for (( j=1; j<=$coins; j++ ))
		do
			randomCoin=$((RANDOM%2+1))
			if [[ $randomCoin -eq 1 ]]
			then
				coinFlip+="H"
			elif [[ $randomCoin -eq 2 ]]
			then
				coinFlip+="T"
			fi
		done

		if [[ $coins -eq $SINGLET ]]
		then
			coinDict1[$coinFlip]=$((${coinDict1[$coinFlip]}+1))
			max=$( percentage1 $coinFlip )
		elif [[ $coins -eq $DOUBLET ]]
		then
			coinDict2[$coinFlip]=$((${coinDict2[$coinFlip]}+1))
			max=$( percentage2 $coinFlip )
		else
			coinDict3[$coinFlip]=$((${coinDict3[$coinFlip]}+1))
			max=$( percentage3 $coinFlip )
		fi
	done

	echo $max
}

echo "Singlet flip coin"
read -p "Number of flips: " no_of_flips
SINGLET=1
singletMax=$( flipSimulator $SINGLET $no_of_flips )
echo "Singlet Winning Combination: $singletMax"

echo "Doublet flip coin "
read -p "Number of flips: " no_of_flips
DOUBLET=2
doubletMax=$( flipSimulator $DOUBLET $no_of_flips )
echo "Doublet Winning Combination: $doubletMax"

echo "Triplet flip coin"
read -p "Number of Flips: " no_of_flips
TRIPLET=3
tripletMax=$( flipSimulator $TRIPLET $no_of_flips )
echo "Triplet Winning Combination: $tripletMax"
