####Text adventure by Dustin Bermudez
###Honestly going to change a lot of stuff
#!/usr/bin/bash
## Placeholder for 0
ZERO=0

###############################################################################################
## This is a test function space for functions I'm testing because I can't be bothered with ##
## putting them together correctly.                                                         ##
###############################################################################################


################################################################################################
###################################### Encounters and Encounter triggers #######################
###############################################################################################

Enemy() {

    Randos=( "Street_Rat" "Corner_Dealer" "Bag_man" "Enforcer" "Pimp" "Hustler" "Hobo" "Escort" "Popo" )

    if [[ $floor == 0 ]]; then
    Mob="${Randos[$(( $RANDOM % 2 ))]}"
    Mobhp=$(( $RANDOM % 5 +11 ))
    Mobatk=$(( $RANDOM % 2 +3 ))
    Mobmag=$(( $RANDOM % 2 +3 ))
    Mobspd=$(( $RANDOM % 2 +3 ))
    battlexp=$(( $RANDOM % 15 +10  ))
    battlecoin=$(( $RANDOM % 50 +10 ))  

    elif [[ $floor == 1 ]]; then

    Mob="${Randos[$(( $RANDOM % 5 ))]}"
    Mobhp=$(( $RANDOM % 8 +15 ))
    Mobatk=$(( $RANDOM % 3 +4 ))
    Mobmag=$(( $RANDOM % 3 +4 ))
    Mobspd=$(( $RANDOM % 3 +4 ))
    battlexp=$(( $RANDOM % 20 +10 ))
    battlecoin=$(( $RANDOM % 70 +20 ))  
    
    elif [[ $floor == 2 ]]; then
    
    Mob="${Randos[$(( $RANDOM % 7 ))]}"
    Mobhp=$(( $RANDOM % 12 +15 ))
    Mobatk=$(( $RANDOM % 6 +6 ))
    Mobmag=$(( $RANDOM % 6 +6 ))
    Mobspd=$(( $RANDOM % 6 +6 ))
    battlexp=$(( $RANDOM % 25 +10))
    battlecoin=$(( $RANDOM % 90 +30 ))  
    
    elif [[ $floor == 3 ]]; then
    
    Mob="${Randos[$(( $RANDOM % 9 ))]}"
    Mobhp=$(( $RANDOM % 8 +15 ))
    Mobatk=$(( $RANDOM % 10 +10 ))
    Mobmag=$(( $RANDOM % 10 +10 ))
    Mobspd=$(( $RANDOM % 10 +10 ))
    battlexp=$(( $RANDOM % 30 +10))
    battlecoin=$(( $RANDOM % 100 +50 ))    
    fi
}

################################# Enemy random encounter  ####################################################
EnemyEncounter() 
{
    Battle="What would you like to do"
    postbattlehp=$hp
    EquippedAttackWeapon
    echo "$Mob has shown up and they acting wild, looks like a fight"
    while true; do
        select batmenu in Attack Defend Run; do
            case $batmenu in
                Attack)
                    Mobhp=$(( $Mobhp - $(( $attack + $weapon ))))
                    if [[ $Mobhp < 1 ]];then
                        echo "$Mob has been merked"
                        echo "You got $battlexp XP"
                        coin=$(( $coin + $battlecoin ))
                        echo "$Mob had $battlecoin bills in their pockets, yours now my G you have $coin bills"
                        DropChance
                        Experience
                        sleep 2
                        hp=$postbattlehp
                        break 2
                    else
                        echo "You hit $Mob for $(($attack + $weapon))"
                        echo "$Mob has $Mobhp remaining"
                        MAssault
                        if [[ $postbattlehp < 1 ]];then
                            echo "You got got"
                            echo "You got a cap popped in you"
                            echo "They got them cheeks"
                            exit 0
                            break 2
                        fi
                    fi
                        
                ;;
                Defend)
                  ##### Defend option gives you defense against an attack and I'll add a healing function for a little bit of HP ##########
                    echo "you defended"
                    echo "The $Mob attacks"
                    mindef=$(( $lvl + $armor ))
                    defense=$(( $RANDOM%10 + $mindef ))
                    defenceatk=$(( $Mobatk - $defense ))
                    postbattlehp=$(( $postbattlehp - $defenceatk ))
                    if [[ $postbattlehp < 1 ]];then
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 
                        else
                            echo "You got hit  for $defenceatk"
                            sleep 0.5
                            echo "You ate one of your twinkies, and recovered your health"
                            postbattlehp=$(( $postbattlehp + $(( $RANDOM % 10 +1 )) ))
                            sleep 0.4
                            echo "You have $postbattlehp remaining"
                            sleep 0.4
                        fi
                ;;
                Run)
                    if [[ $((RANDOM%4 +1)) == 1 ]]; then
                    echo "You ran"
                    break 2 
                else
                    echo "You failed to get away"
                    echo "$Mob attacks"
                        MAssault
                        if [[ $postbattlehp < 1 ]];then
                            echo "You got got"
                            sleep 1
                            echo "You got a cap popped in you"
                            sleep 1
                            echo "Worse of all you showed them cheeks"
                            sleep 1
                            echo "They got into them cheeks dawg, damn"
                            exit 0
                            break 2
                        else
                            echo "You got hit for $Mobatk"
                            sleep 0.5
                            echo "You have $postbattlehp remaining"
                            sleep 0.5
                        fi
                fi
                ;;
            esac
            
        done
    done
        
}

MAssault(){
  hit=$speed
  swing=$(( $RANDOM % 20 +1 ))
  if [[ $(( $swing + $Mobspd )) -ge $hit ]]; then
    echo "$Mob attacks"
    if [[ $swing == 20 ]]; then
      postbattlehp=$(( $postbattlehp - $(($(( $Mobatk * 2 )) - $armor ))))
      printf "$Mob landed a critical hit \n You take $(($(( $Mobatk * 2 )) - $armor )) damage \n You have $postbattlehp hp remaining\n"
    else
    postbattlehp=$(( $postbattlehp - $(($Mobatk - $armor))))
    printf "You got hit for $(($Mobatk - $armor)) damage \nYou have $postbattlehp hp remainaing\n"
    fi
  elif [[ $(( $swing + $floor )) -lt $hit ]]; then
    printf "$Mob attacks \n$Mob missed\n"
  fi
    
}


############################ Encounter Triggers ##############################################

Encounter() {
    ChanceEncounter=( "Bae" "Merchant" "Foe" "Old Hag" "Hoe" "Bag boy" "Money" )
    if [[ $floorspace > 0 ]]; then
    HotStep=$(( $RANDOM %$floorspace +1 ))
    if [[ $Blocks == $HotStep ]]; then
        RNG=${ChanceEncounter[$(( $RANDOM % 7 ))]}
        ((triggers++))
        if [[ $RNG == "Bae" ]]; then
          Bae
        elif [[ $RNG == "Merchant" ]]; then
        Merchant
        elif [[ $RNG == "Foe" ]]; then
        Enemy
        EnemyEncounter
        elif [[ $RNG == "Old Hag" ]]; then
        Oldhag
        elif [[ $RNG == "Hoe" ]]; then
        Hoe
        elif [[ $RNG == "Bag Boy" ]]; then
           Bagboy
        elif [[ $RNG == "Money" ]]; then
            Money
        else
            echo "Nothing happened"
        fi
    fi
elif [[ $floorspace -le 0 ]]; then
    echo "It appears like a smooth walk"
fi


}

##### This is to keep track of encounters so people don't spam inspect the block over and over

inspectblock=0
triggers=0


#################################### Encounter Types ######################################
################### This is a function for each encounter type ############################

######### Bae who heals full HP
baecounter=0
Bae()
{
            ((baecounter++))
            if [[ $homiecounter < 10 ]]; then
                echo "You link up with Bae"
                sleep 1
                echo "Bae came through"
                sleep 1.5
                echo "Bae gave you that good good"
                postbattlehp=$(( $maxhp + $postbattlehp ))
                sleep 1.5
                echo "You feel like you take take over the world, fully recovered HP"
                echo "You have $postbattlehp"
                hp=$postbattlehp
                sleep 3
            elif [[ $homiecounter -ge 10 ]]; then
                if [[ $baecounter -gt 5 ]]; then
                    if [[ $sbosshp2 > 0 ]]; then
                        BossBae
                    else
                        echo "Bae's pimp is dead, but I mean can you stay with a ho?"
                        sleep .3
                        echo "......"
                        sleep .3
                        echo "....."
                        sleep .3
                        echo "...."
                        sleep .3
                        echo "..."
                        sleep .3
                        echo ".."
                        sleep .3
                        echo "."
                        sleep .3
                        echo " "
                        sleep .3
                        echo "Naw you left that bitch she can stay a hoe, shes for the streets and just because you becoming a Steet King ain't mean you gotta take a hoe."
                        sleep .3
                        echo "Real recognize Real and you coming in loud and clear."
                    fi
                else
                    echo "You link up with Bae"
                    sleep 1
                    echo "Bae came through"
                    sleep 1.5
                    echo "Bae gave you that good good"
                    postbattlehp=$(( $maxhp + $postbattlehp ))
                    sleep 1.5
                    echo "You feel like you take take over the world, fully recovered HP"
                    echo "You have $postbattlehp"
                    sleep 3
                fi
            fi

}

############# Old hag who buffs/weakens if you have the money, also will make secret boss I hate this hag
oldhagcounter=0
Oldhag()
{
    ((oldhagcounter++))
        if [[ $homiecounter < 11 ]]; then
            echo "An Old hag approaches you
            She asks for help, she is in need of money
            do you want to give some (y/n)?"
            read Oldlady
            if [[ $Oldlady == "y" ]]; then
                echo "The Old Hag thanks you"
                sleep 1
                Pocket
                if [[ $coin -gt 0 ]]; then
                    donation=$(( $RANDOM % 20 + 1 ))
                    echo "You gave the old hag $donation bills"
                    coin=$(( $coin - $donation ))
                    Pocket
                    echo "You feel bless"
                    sleep 1
                    attack=$(( $attack + $(( $RANDOM%4 + 1 )) ))
                    magic=$(( $magic + $(( $RANDOM%4 + 1 )) ))
                    echo "Your strength has gone up!"
                    echo "Your new magic is $magic"
                    echo "Your new attack is $attack"
                    sleep 1
                elif [[ $coin -le 0 ]]; then 
                    sleep 1
                    echo "...."
                    sleep 1
                    echo "The old lady tells you off, get your hood, gangster broke ass out of here."
                    sleep 1
                    echo "...."
                    sleep 1
                    echo "broke ass"
                fi
            elif [[ $Oldlady == "n" ]]; then
                echo "The old hag is scorned"
                sleep 1
                echo "She curses you"
                sleep 1
                echo "You feel weaker"
                postbattlehp=$(( $postbattlehp - $(( $RANDOM % 5 +1 )) ))
                attack=$(( $attack - $(( $RANDOM % 3 +1 )) ))
                magic=$(( $magic - $(( $RANDOM % 3 +1 )) ))
                speed=$(( $speed - $(( $RANDOM % 3 +1 )) ))
                sleep 1
                echo "Your attack is $attack, your magic is $magic your speed is $speed"
                sleep 1
                echo "Damn that Old hag"
            else
                echo "She leave but you feel your pockets lighter"
                theif=$(( $RANDOM % 50 + 1 ))
                coin=$(( $coin - $theif ))
                sleep 1
                echo "You lost $theif bills"
                Pocket
            fi
        elif [[ $homiecounter -ge 11 ]]; then
            if [[ oldhagcounter -ge 5 ]]; then
                if [[ sbosshp1 > 0 ]]; then
                    BossOldHag
                else 
                    echo "The Old thot is dead, ain't nothing coming through..."
                    sleep 1
                    echo "You want more secret content? Stop asking just keep trying to get the rest of the legendary gear you going to need that G-Wagon for later"
                fi
            else
                echo "An Old hag approaches you

                She asks for help, she is in need of money

                do you want to give some (y/n)?"
                read Oldlady
            
                if [[ $Oldlady == "y" ]]; then
                    echo "The Old Hag thanks you"
                    sleep 1
                    Pocket
                    if [[ $coin -gt 0 ]]; then
                        donation=$(( $RANDOM % 20 + 1 ))
                        echo "You gave the old hag $donation bills"
                        coin=$(( $coin - $donation ))
                        Pocket
                        echo "You feel bless"
                        sleep 1
                        attack=$(( $attack + $(( $RANDOM%4 + 1 )) ))
                        magic=$(( $magic + $(( $RANDOM%4 + 1 )) ))
                        echo "Your strength has gone up!"
                        echo "Your new magic is $magic"
                        echo "Your new attack is $attack"
                        sleep 1
                    else 
                        sleep 1
                        echo "...."
                        sleep 1
                        echo "The old lady tells you off, get your hood, gangster broke ass out of here."
                        sleep 1
                        echo "...."
                        sleep 1
                        echo "broke ass"
                    fi
                elif [[ $Oldlady == "n" ]]; then
                    echo "The old hag is scorned"
                    sleep 1
                    echo "She curses you"
                    sleep 1
                    echo "You feel weaker"
                    postbattlehp=$(( $postbattlehp - $(( $RANDOM % 5 +1 )) ))
                    attack=$(( $attack - $(( $RANDOM % 3 +1 )) ))
                    magic=$(( $magic - $(( $RANDOM % 3 +1 )) ))
                    speed=$(( $speed - $(( $RANDOM % 3 +1 )) ))
                    sleep 1
                    echo "Your attack is $attack, your magic is $magic your speed is $speed"
                    sleep 1
                    echo "Damn that Old hag"
                else
                    echo "She leave but you feel your pockets lighter"
                    theif=$(( $RANDOM % 50 + 1 ))
                    coin=$(( $coin - $theif ))
                    sleep 1
                    echo "You lost $theif bills"
                    Pocket
                fi
            fi
        fi
}

############# Hoe heals some hp for some money

Hoe()
{
  echo "A Hoe has shown up"
            sleep 1
            echo "They offers some lovin for some stacks"
            sleep 1
            echo "Do you want some? (y/n)"
            read Hoebag
                if [[ $Hoebag == "y" ]]; then
                    echo "You get some cheeks"
                    sleep 1
                    Pocket
                    if [[ $coin -gt 0 ]]; then
                    Hoemoney=$(( RANDOM % 10 +1 ))
                    coin=$(( $coin - $Hoemoney ))
                    echo "You paid $Hoemoney bills" 
                    Pocket                   
                    postbattlehp=$(( $postbattlehp + $(( $RANDOM % 20 +1 )) ))
                    echo "You recovered some health your hp is now $postbattlehp"
                else
                    echo "You broke ass bitch screams the hoe"
                    fi
                elif [[ $Hoebag == "n" ]]; then
                    echo "She leaves you"
                    sleep 1
                    echo "You broke bitch"
                else
                    echo "You ugly, I don't want you anyways"
                    echo "The Hoe walks away"
                fi
}

####### Bagboy drops a lot of money

Bagboy()
{
   echo "Bag Boy runs up to drop you off the money from this weeks work"
            sleep 1
            echo "Its a bag of stacks"
            stack=$(( $RANDOM % 50 +10 ))
            coin=$(( $coin + $stack ))
            sleep 1
            echo "You got $stack in bills, you got $coin bills"
}

############ You find a small amount of money

Money()
{
  echo "You found some money"
            sleep 1
            echo "Its a small stack, covered in blood"
            sleep 1
            echo "Yours now"
            stack=$(( $RANDOM % 10 +2 ))
            coin=$(( $coin + $stack ))
            echo "You got $stack in money, you got $coin bills"
}

############################################################################################
################################# Array for the weapon shop ################################
############################################################################################

################################# Attack Weapons list for the weapons shop ##################
AttackWeapons(){
    knife1="Butterfly"
    knife2="Hunting"
    knife3="Machete"
    knife4="Brutus_Backstabber"
    atkweaponshop=($knife1 $knife2 $knife3)
}

################################ Magic Weapon list for weapons shop #######################
MagicWeapons(){
    gun1="Desert_Eagle"
    gun2="Uzi"
    gun3="Shotgun"
    gun4="The_Revolutionary_AK47"
    magweaponshop=($gun1 $gun2 $gun3)
}

########################## Basketball Weapon list for weapons shop #########################
BasketballWeapons(){
    ball1="Inflated_Basketball"
    ball2="Regulation_Basketball"
    ball3="All-Star_Signed_Basketball"
    ball4="Golden_WorldChampionBasketball"
    ballweaponshop=($ball1 $ball2 $ball3)
}

############################### Scare Weapon list for weapons shop ########################
ScareWeapons(){
    scare1="Flickering_lights"
    scare2="Spooky_Noise"
    scare3="Possession"
    scare4="DemonicPossession"
    scareweaponshop=($scare1 $scare2 $scare3)
}

############################## Armor list for armor shop ####################################
Armors(){
    armor1="Jeans"
    armor2="Hoodie"
    armor3="Dope_Bling"
    armor4="G-Wagon"
    armorshop=($armor1 $armor2 $armor3)
}

######################## Assigning bonus attack damage to each weapon ########################
EquippedAttackWeapon(){
    case $weapon in
      Shiv)
        weapon=0
      ;;
      Butterfly)
        weapon=4
      ;;
      Hunting)
        weapon=8
      ;;
      Machete)
        weapon=16
      ;;
      Brutus_Backstabber)
        weapon=50
      ;;
    esac
  
  case $weapon in
      Glock)
        weapon=0
      ;;
      Desert_Eagle)
        weapon=4
      ;;
      Uzi)
        weapon=8
      ;;
      Shotgun)
        weapon=16
      ;;
      The_Revolutionary_AK47)
        weapon=50
      ;;
    esac

  case $weapon in
      Deflated_Basketball)
        weapon=0
      ;;
      Inflated_Basketball)
        weapon=4
      ;;
      Regulation_Basketball)
        weapon=8
      ;;
      All-Star_Signed_Basketball)
        weapon=16
      ;;
      Golden_WorldChampionBasketball)
        weapon=50
      ;;
    esac
  
  case $weapon in
      Haunt)
        weapon=0
      ;;
      Flickering_lights)
        weapon=4
      ;;
      Spooky_Noise)
        weapon=8
      ;;
      Possession)
        weapon=16
      ;;
      DemonicPossession)
        weapon=50
      ;;
    esac
    case $armor in
      Jeans)
        armor=5
      ;;
      Hoodie)
        armor=8
      ;;
      Dope_Bling)
        armor=11
      ;;
      G-Wagon)
        armor=20
      ;;
    esac
}
    
#########################################################################################################################################################
################################################ Battle Menu and Battle Function ########################################################################
#########################################################################################################################################################

#########################################################Boss Fights#############################################################################
BossFight() {
    Battle="What would you like to do"
    postbattlehp=$hp
    EquippedAttackWeapon
    while true; do
        select batmenu in Attack Defend Run; do
            case $batmenu in
                Attack)
                    bosshp=$(( $bosshp - $(( $attack + $weapon ))))
                    if [[ $bosshp < 1 ]];then
                      sleep .3
                        echo "The $boss has been slain"
                        sleep .4
                        echo "You got 100 XP"
                        sleep .4
                        battlexp=100
                        sleep 1.2
                        DropChance
                        sleep 1.2
                        hp=$postbattlehp
                        Experience
                        coin=$(( $coin + $battlecoin ))
                        echo "The $boss had some deep pockets you got $battlecoin bills"
                        echo "You now have $coin bills in your pockets"
                        sleep 1.2
                        if [[ $floor == 0 ]]; then
                            boss1hp=$bosshp
                            echo "You cleared out the mobile home in Fairfax, You own these trailertrash, time to move on to city of Springfield"
                        elif [[ $floor == 1 ]]; then
                            boss2hp=$bosshp
                            echo "You cleared out Springfield, You own this city, running all the gangs here, time to move on to a bigger city Washington"
                        elif [[ $floor == 2 ]]; then
                            boss3hp=$bosshp
                            echo "You cleared out Washington of all rivals, time for some big league moves, time to take over San Jose"
                        elif [[ $floor == 3 ]]; then
                            boss4hp=$bosshp  
                        fi
                        sleep 2
                        break 2
                    else
                        echo "You hit the $boss for $(($attack + $weapon))"
                        sleep 1.1
                        echo "The $boss has $bosshp remaining"
                        sleep 0.8
                        BAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 0.4
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.5
                            exit 0
                            break 2
                        fi
                    fi
                        
                ;;
                Defend)
                  ##### Defend option but once you can figure out how to get it going ##########
                    echo "you defended"
                    echo "The $boss attacks"
                    mindef=$(( $lvl + $armor ))
                    defense=$(( $RANDOM%10 + $mindef ))
                    defenceatk=$(( $bossatk - $defense ))
                    postbattlehp=$(( $postbattlehp - $defenceatk ))
                    if [[ $postbattlehp < 1 ]];then
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 
                        else
                            echo "You got hit  for $defenceatk"
                            echo "While you were getting hit you sneaked a snack in"
                            recover=$(( $RANDOM % 10 +3  ))
                            postbattlehp=$(( $postbattlehp + $recover ))
                            echo "you recovered $recover hp" 
                            echo "You have $postbattlehp remaining"
                        fi
                ;;
                Run)
                    if [[ $((RANDOM%4 +1)) == 1 ]]; then
                    echo "This is a boss fight, You think you can run?!? YOU A DAMN FOOL!"
                     sleep 0.8
                     BAssault
                     if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.4
                            exit 0
                            break 2
                        else
                          sleep 0.4
                            echo "You got hit for $bossatk"
                            sleep 0.5
                            echo "You have $postbattlehp remaining"
                            sleep 0.5
                        fi
                else
                    echo "You failed to get away"
                    echo "The $boss attacks"
                        BAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 2
                        else
                            echo "You got hit for $bossatk"
                            echo "You have $postbattlehp remaining"
                        fi
                fi
                ;;
            esac
            
        done
    done
            
}


################################ Secret Boss fights ########################################
sbosshp1=1
sbosshp2=1
sbosshp3=1

sboss="Name"
sbosshp=1
sbossatk=1
sbossspd=1



BossOldHag() {
    boldhag="Old Thot"
    boldhaghp=$(( $RANDOM % 50 +70 ))
    boldhagatk=$(( $RANDOM % 35 + 20))
    boldhagspeed=$(( $RANDOM % 20 +15 ))
    sboss=$boldhag
    sbosshp=$boldhaghp
    sbossatk=$boldhagatk
    sbossspd=$boldhagspeed
    echo "The Old hag stands up right."
    sleep 1
    echo "For an old bitty she stacked"
    sleep 1
    echo "She is an old thot and she's in heat!"
    sleep 1
    echo "Looks like you in for a tough struggle."
    Battle="What would you like to do"
    postbattlehp=$hp
    EquippedAttackWeapon
    while true; do
        select batmenu in Attack Defend Run; do
            case $batmenu in
                Attack)
                    sbosshp=$(( $sbosshp - $(( $attack + $weapon ))))
                    if [[ $sbosshp < 1 ]];then
                      sleep .3
                        echo "The $sboss has been dropped"
                        sleep .4
                        echo "You got 100 XP"
                        sleep .4
                        battlexp=100
                        sleep 1.2
                        echo "...You beat the $sboss back..."
                        sleep 1.2
                        echo "....thats street king material right there.."
                        sleep 1.1
                        echo "...little messed up beating an old lady though..."
                        hp=$postbattlehp
                        Experience
                        coin=$(( $coin + 1000 ))
                        echo "The Old Thot was rich!"
                        sleep 1
                        echo "She had a full stack of bills on her!"
                        sleep 1
                        echo "She was using that coochie for evil!"
                        sleep 1
                        echo "You got a ton of money now though so for the better good?"
                        sleep 1
                        echo "You now have $coin bills in your pockets"
                        sleep 1.2
                        echo ""
                        sleep 2
                        sbosshp1=0
                        break 2
                    else
                        echo "You hit the Old Thot for $(($attack + $weapon))"
                        sleep 1.1
                        echo "The $sboss has $sbosshp remaining"
                        sleep 0.8
                        SBAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 0.4
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.5
                            exit 0
                            break 2
                        fi
                    fi
                        
                ;;
                Defend)
                  ##### Defend option but once you can figure out how to get it going ##########
                    echo "you defended"
                    echo "The $sboss attacks"
                    mindef=$(( $lvl + $armor ))
                    defense=$(( $RANDOM%10 + $mindef ))
                    defenceatk=$(( $sbossatk - $defense ))
                    postbattlehp=$(( $postbattlehp - $defenceatk ))
                    if [[ $postbattlehp < 1 ]];then
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 
                        else
                            echo "You got hit  for $defenceatk"
                            echo "While you were getting hit you sneaked a snack in"
                            recover=$(( $RANDOM % 10 +3  ))
                            postbattlehp=$(( $postbattlehp + $recover ))
                            echo "you recovered $recover hp" 
                            echo "You have $postbattlehp remaining"
                        fi
                ;;
                Run)
                    if [[ $((RANDOM%4 +1)) == 1 ]]; then
                    echo "This is a boss fight, You think you can run?!? YOU A DAMN FOOL!"
                     sleep 0.8
                     SBAssault
                     if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.4
                            exit 0
                            break 2
                        else
                          sleep 0.4
                            echo "You got hit for $sbossatk"
                            sleep 0.5
                            echo "You have $postbattlehp remaining"
                            sleep 0.5
                        fi
                else
                    echo "You failed to get away"
                    echo "The $sboss attacks"
                        BAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 2
                        else
                            echo "You got hit for $sbossatk"
                            echo "You have $postbattlehp remaining"
                        fi
                fi
                ;;
            esac
            
        done
    done
            
}

BossBae() 
{
    sboss="A Pimp named Slick Rick"
    sbosshp=$(( $RANDOM % 50 +70 ))
    sbossatk=$(( $RANDOM % 40 + 25))
    sbossspd=$(( $RANDOM % 20 +17 )) 
    echo "You get a text from bae saying they are on their way"
    sleep 1
    echo "They tell you to meet them at the corner of Secret and Boss"
    sleep 1
    echo "You arrive...."
    sleep 1
    echo "...."
    sleep 1
    echo "..."
    sleep 1
    echo "...this is sus...."
    sleep 1
    echo "*SLAP* You just got pimped slapped! "
    sleep 1
    echo 
    echo "It looks like the pimp homie told you about $sboss"
    sleep 1
    echo "Looks its a fight, gotta get your respect back!"
    Battle="What would you like to do"
    postbattlehp=$hp
    EquippedAttackWeapon
    while true; do
        select batmenu in Attack Defend Run; do
            case $batmenu in
                Attack)
                    sbosshp=$(( $sbosshp - $(( $attack + $weapon ))))
                    if [[ $sbosshp < 1 ]];then
                      sleep .3
                        echo "The $sboss has been dropped"
                        sleep .4
                        echo "You got 100 XP"
                        sleep .4
                        battlexp=100
                        sleep 1.2
                        echo "...You beat the $sboss ..."
                        sleep 1.2
                        echo "....thats street king material right there.."
                        sleep 1.1
                        echo "...bae was a hoe this whole time though? damn that's messed up ......"
                        hp=$postbattlehp
                        Experience
                        coin=$(( $coin + 3000 ))
                        echo "$sboss was rich! What did you expect from a pimp?"
                        sleep 1
                        echo "They had a full stack of bills on them!"
                        sleep 1
                        echo "They got bling for days!"
                        sleep 1
                        echo "You got a ton of money now though so for the better good?"
                        sleep 1
                        echo "You now have $coin bills in your pockets"
                        sleep 1.2
                        echo ""
                        sleep 2
                        sbosshp2=0
                        break 2
                    else
                        echo "You hit the Old Thot for $(($attack + $weapon))"
                        sleep 1.1
                        echo "The $sboss has $sbosshp remaining"
                        sleep 0.8
                        SBAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 0.4
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.5
                            exit 0
                            break 2
                        fi
                    fi
                        
                ;;
                Defend)
                  ##### Defend option but once you can figure out how to get it going ##########
                    echo "you defended"
                    echo "The $sboss attacks"
                    mindef=$(( $lvl + $armor ))
                    defense=$(( $RANDOM%10 + $mindef ))
                    defenceatk=$(( $sbossatk - $defense ))
                    postbattlehp=$(( $postbattlehp - $defenceatk ))
                    if [[ $postbattlehp < 1 ]];then
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 
                        else
                            echo "You got hit  for $defenceatk"
                            echo "While you were getting hit you sneaked a snack in"
                            recover=$(( $RANDOM % 10 +20  ))
                            postbattlehp=$(( $postbattlehp + $recover ))
                            echo "you recovered $recover hp" 
                            echo "You have $postbattlehp remaining"
                        fi
                ;;
                Run)
                    if [[ $((RANDOM%4 +1)) == 1 ]]; then
                    echo "This is a boss fight, You think you can run?!? YOU A DAMN FOOL!"
                     sleep 0.8
                     SBAssault
                     if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.4
                            exit 0
                            break 2
                        else
                          sleep 0.4
                            echo "You got hit for $sbossatk"
                            sleep 0.5
                            echo "You have $postbattlehp remaining"
                            sleep 0.5
                        fi
                else
                    echo "You failed to get away"
                    echo "The $sboss attacks"
                        BAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 2
                        else
                            echo "You got hit for $sbossatk"
                            echo "You have $postbattlehp remaining"
                        fi
                fi
                ;;
            esac
            
        done
    done
            

           
}

BossHomie() {
    clear
    sboss="Homie"
    sbosshp=$(( $RANDOM % 50 +200 ))
    sbossatk=$(( $RANDOM % 40 + 40))
    sbossspd=$(( $RANDOM % 20 +50 )) 
    echo "You have reached the top"
    sleep 1
    echo "You have an empire to run"
    sleep 1
    echo "All of a sudden an all Gold G-Wagon rolls up on you"
    sleep 1
    echo "You hear a voice yell at you"
    sleep "......"
    sleep 1
    echo "Heeeeyyyy Homie, thanks for taking everyone out"
    sleep 1
    echo "But looks like you and me got to dance a little"
    sleep 1
    echo "We gotta find out who the real Street King is...."
    sleep 1
    echo "Motherfucka"
    sleep 1
    echo "This is your homie, your boy, your ride or die and he doing you like this? But the real question is do you stay loyal? Or do you prove to him who the real Street King is? (y/n)"
    read streetking
    if [[ $streetking == "y" ]]; then
    Battle="What would you like to do"
    postbattlehp=$hp
    EquippedAttackWeapon
    while true; do
        select batmenu in Attack Defend Run; do
            case $batmenu in
                Attack)
                    sbosshp=$(( $sbosshp - $(( $attack + $weapon ))))
                    if [[ $sbosshp < 1 ]];then
                      sleep .3
                        echo "The $sboss has been dropped"
                        sleep .4
                        echo "You got 100 XP"
                        sleep .4
                        battlexp=100
                        sleep 1.2
                        echo "...You beat the $sboss back..."
                        sleep 1.2
                        echo "....thats street king material right there.."
                        sleep 1.1
                        echo "...little messed up beating an old lady though..."
                        hp=$postbattlehp
                        Experience
                        coin=$(( $coin + 1000 ))
                        echo "The Old Thot was rich!"
                        sleep 1
                        echo "She had a full stack of bills on her!"
                        sleep 1
                        echo "She was using that coochie for evil!"
                        sleep 1
                        echo "You got a ton of money now though so for the better good?"
                        sleep 1
                        echo "You now have $coin bills in your pockets"
                        sleep 1.2
                        echo ""
                        sleep 2
                        sbosshp3=0
                        break 2
                    else
                        echo "You hit the Old Thot for $(($attack + $weapon))"
                        sleep 1.1
                        echo "The $sboss has $sbosshp remaining"
                        sleep 0.8
                        SBAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 0.4
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.5
                            exit 0
                            break 2
                        fi
                    fi
                        
                ;;
                Defend)
                  ##### Defend option but once you can figure out how to get it going ##########
                    echo "you defended"
                    echo "The $sboss attacks"
                    mindef=$(( $lvl + $armor ))
                    defense=$(( $RANDOM%10 + $mindef ))
                    defenceatk=$(( $sbossatk - $defense ))
                    postbattlehp=$(( $postbattlehp - $defenceatk ))
                    if [[ $postbattlehp < 1 ]];then
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 
                        else
                            echo "You got hit  for $defenceatk"
                            echo "While you were getting hit you sneaked a snack in"
                            recover=$(( $RANDOM % 10 +3  ))
                            postbattlehp=$(( $postbattlehp + $recover ))
                            echo "you recovered $recover hp" 
                            echo "You have $postbattlehp remaining"
                        fi
                ;;
                Run)
                    if [[ $((RANDOM%4 +1)) == 1 ]]; then
                    echo "This is a boss fight, You think you can run?!? YOU A DAMN FOOL!"
                     sleep 0.8
                     SBAssault
                     if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            sleep 0.4
                            echo "You got a cap popped in you"
                            sleep 0.4
                            exit 0
                            break 2
                        else
                          sleep 0.4
                            echo "You got hit for $sbossatk"
                            sleep 0.5
                            echo "You have $postbattlehp remaining"
                            sleep 0.5
                        fi
                else
                    echo "You failed to get away"
                    echo "The $sboss attacks"
                        BAssault
                        if [[ $postbattlehp < 1 ]];then
                          sleep 
                            echo "You were got"
                            echo "You got a cap popped in you"
                            exit 0
                            break 2
                        else
                            echo "You got hit for $sbossatk"
                            echo "You have $postbattlehp remaining"
                        fi
                fi
                ;;
            esac
            
        done
    done
      elif [[ $streetking == n ]]; then
      echo "Awww you willing to step down for me you the realest"
      sleep 1
      echo "You feel hot liquid come down your chest"
      echo "You are in shock"
      echo "The world starts to dim as all you hear is laughter"
      sleep 5
      echo "You Died like a gd fool, a clown, you hustled to the top by let your self suck on those nuts next time handle yourself...."      
      exit 0
  else
    echo "What are you doing?"
fi
}

MAssault(){
  hit=$speed
  swing=$(( $RANDOM % 20 +1 ))
  if [[ $(( $swing + $sbossspd )) -ge $hit ]]; then
    echo "$Mob attacks"
    if [[ $swing -ge 19 ]]; then
      postbattlehp=$(( $postbattlehp - $(($(( $sbossatk * 2 )) - $armor ))))
      printf "$sboss landed a critical hit \n You take $(($(( $sbossatk * 2 )) - $armor )) damage \n You have $postbattlehp hp remaining\n"
    else
    postbattlehp=$(( $postbattlehp - $(($sbossatk - $armor))))
    printf "You got hit for $(($sbossatk - $armor)) damage \nYou have $postbattlehp hp remainaing\n"
    fi
  elif [[ $(( $swing + $floor )) -lt $hit ]]; then
    printf "$sboss attacks \n$sboss missed\n"
  fi
    
}

################################# Function to track money ###################################

Pocket()
{
    if [[ $coin < 1 ]]; then
                        echo "Your pockets are empty"
                        ###### Reset money so no negative money
                        coin=0
                        sleep 1
                    else
                        echo "You have $coin bills left"
                    fi
}    
    
################################# Function to track experience ###############################
    
Experience() {
    xp=$(( $xp + $battlexp ))
    if [[ $xp -ge 100 ]];then
        xp=0
        echo "You leveled up"
        lvl=$(( $lvl + 1))
        maxhp=$(( $maxhp + $(( $RANDOM%10 +5))))
        attack=$(( $attack + $(( $RANDOM%10 +5))))
        magic=$(( $magic + $(( $RANDOM%10 +5))))
        speed=$(( $speed + $(( $RANDOM%2 ))))
        hp=$maxhp
        echo "You are now level $lvl
your stats have gone up
Hp is $hp
attack is $attack
magic is $magic
speed is $speed
"
    else
        remainingexp=$(( 100 - $xp))
        echo "You gained $battlexp exp, you now have $xp exp, you need $remainingexp exp"
    fi
}

################################### Post Battle win drop chance for legendary gear ############

DropChance() 
{
    if [[ $homiecounter < 19 ]]; then
        itemdrop=$(( $RANDOM % 20 +1 ))
        AttackWeapons
        MagicWeapons
        BasketballWeapons
        ScareWeapons
        Armors
        legendarydrop=( $knife4 $gun4 $ball4 $scare4 $armor4 )
        if [[ $itemdrop -ge 19 ]]; then
            drip=${legendarydrop[$(( $RANDOM % 5 ))]}
            if [[ $drip == $knife4 || $drip == $gun4 || $drip == $ball4 || $drip == $scare4 ]]; then
                echo "Looks like you got some extra special from this one"
                sleep 1.2
                echo "Looks like they drop $drip"
                sleep 1.2
                echo "Dang thats some special ice"
                weapon="$drip"
            elif [[ $drip == $armor4 ]]; then 
                echo "Looks like some keys were dropped"
                sleep 1.2
                echo "Looks like car keys"
                sleep 1.2
                echo "My G, you true baller with that new G-Wagon"
                armor=$drip
            fi
        else
            echo "Nothing special from this foo"
            echo " "
            echo " "
        fi
    else 
        itemdrop=$(( $RANDOM % 20 +1 ))
        AttackWeapons
        MagicWeapons
        BasketballWeapons
        ScareWeapons
        Armors
        legendarydrop=( $knife4 $gun4 $ball4 $scare4 $armor4 )
        if [[ $itemdrop -ge 1 ]]; then
            drip=${legendarydrop[$(( $RANDOM % 5 ))]}
            if [[ $drip == $knife4 || $drip == $gun4 || $drip == $ball4 || $drip == $scare4 ]]; then
                echo "Looks like you got some extra special from this one"
                sleep 1.2
                echo "Looks like they drop $drip"
                sleep 1.2
                echo "Dang thats some special ice"
                weapon="$drip"
            elif [[ $drip == $armor4 ]]; then 
                echo "Looks like some keys were dropped"
                sleep 1.2
                echo "Looks like car keys"
                sleep 1.2
                echo "My G, you true baller with that new G-Wagon"
                armor=$drip
            fi
        else
            echo "Nothing special from this foo"
            echo " "
            echo " "
        fi
    fi
}


######################### Function to generate a boss with semi-random stats ##################

BossCheck() {
        boss1hp=1
    boss2hp=1
    boss3hp=1
    boss4hp=1
}


Floorboss() {

    Floorlevel
    Floorsize

    if [[ $floor == 0 ]]; then
        BossName=( "Marcus" "Julius" "Agustus" "Nero" "Legatus" "Caesar" "Tiberius" "Caligula") 
    boss="${BossName[$(( $RANDOM % 8 ))]}"
    bosshp=$(( $RANDOM % 10 +21 ))
    bossatk=$(( $RANDOM % 3 +5 ))
    bossmag=$(( $RANDOM % 3 +8 ))
    bossspd=$(( $RANDOM % 3 +7 ))
    battlecoin=$(( $RANDOM % 30 +50 ))

elif [[ $floor == 1 ]]; then
        BossName=( "Osman" "Orhan" "Murad" "Bayezid" "Shaka Zulu" "Mansa Musa" "Idris Alooma" "Sunni Ali Ber" )
    boss="${BossName[$(( $RANDOM % 8 ))]}"
    bosshp=$(( $RANDOM % 10 +41 ))
    bossatk=$(( $RANDOM % 10 +7 ))
    bossmag=$(( $RANDOM % 10 +10 ))
    bossspd=$(( $RANDOM % 5 +8 ))
    battlecoin=$(( $RANDOM % 50 +80 ))
    
elif [[ $floor == 2 ]]; then
        BossName=( "Alexander" "Cyrus" "Darius" "Genghis Kahn" "Roman" "Xerxes" "Bruno" "Ajax" )
    boss="${BossName[$(( $RANDOM % 8 ))]}"
    bosshp=$(( $RANDOM % 10 +61 ))
    bossatk=$(( $RANDOM % 15 +10 ))
    bossmag=$(( $RANDOM % 15 +12 ))
    bossspd=$(( $RANDOM % 15 +10 ))
    battlecoin=$(( $RANDOM % 80 +100 ))
    
elif [[ $floor == 3 ]]; then
        BossName=( "Fatty T" "Biggie Bigger" "The Large one known as Whale" "D.J. King Kong" "Little WaterBed" "Tea Bags" "Jonesing for the Juice, Jones" "Booty Warrior: Alpha" )
    boss="${BossName[$(( $RANDOM % 8 ))]}"
    bosshp=$(( $RANDOM % 10 +81 ))
    bossatk=$(( $RANDOM % 20 + 12 ))
    bossmag=$(( $RANDOM % 20 + 20 ))
    bossspd=$(( $RANDOM % 20 + 12 ))
    
fi
}

########################### Floor level function based off bosses beat #######################

Floorlevel() {
    if [[ $boss1hp > 0 ]]; then
        floor=0
    elif [[ $boss2hp>0 && $boss1hp<=0 ]]; then
        floor=1
    elif [[ $boss3hp>0 && $boss2hp<=0 ]]; then
        floor=2
    elif [[ $boss4hp>0 && $boss3hp<=0 ]]; then
        floor=3
    elif [[ $boss4hp<=0 ]]; then
        floor=4
    fi
            
}

###################################### Floor size ############################################

Floorsize() {
    Floorlevel
    if [[ $floor == 0 ]]; then
        floorspace=$(( $RANDOM % 10 +11))
    elif [[ $floor == 1 ]]; then
        floorspace=$(( $RANDOM % 20 +21))
    elif [[ $floor == 2 ]]; then
        floorspace=$(( $RANDOM % 30 +31))
    elif [[ $floor == 3 ]]; then
        floorspace=$(( $RANDOM % 40 +51))
    fi
}

##############################################################################################
##################### Functions to run the shops (Allegedly) #################################
##############################################################################################

##############################################################################################
################################### Shop keeper look ###############################
##############################################################################################
#
Merchant() {
 shopoptions="Welcome to my shop, I gots the goods if you gots the bag"
 while true; do
   select shopchoice in Purchase_a_new_Knife Purchase_a_Gun Purchase_a_new_Basketball Purchase_a_better_Scare Purchase_a_new_armor Leave; do
     case $shopchoice in
       Purchase_a_new_Knife)
         if [[ $floor == 1 ]]; then
           AttackWeapons
           #Originally had a case format but going to try to see if I can implement that later
           #Offering what the player can choose to buy from the shop and reading that variable to use for the purcahse weapon function.
            echo "Here are a list of knives 
            1: ${atkweaponshop[0]} 
            that I have availble for you now young thug"
            echo "What do you want to purchase?"
            read sold
            # Accepting either the input of 1 or the weapon name
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${atkweaponshop[0]}" || $sold == "butterfly" || $sold == 1 ]]; then
                PurchaseWeapon
                else
                echo "I don't got that here"
                fi
            echo "Hit enter for menu"
            elif [[ $coin -le 0 ]]; then 
            echo "You Broke"
            fi          
         elif [[ $floor == 2 ]]; then
           AttackWeapons
            echo "Here are a list of knives 
            1: "${atkweaponshop[0]}"
            2: "${atkweaponshop[1]}" 
            that I have availble for you now thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${atkweaponshop[0]}" || $sold == "${atkweaponshop[1]}" || $sold == "hunting" || $sold == "butterfly" || $sold == 1 || $sold == 2 ]]; then
                PurchaseWeapon
                else
                echo "I don't got that here"
                fi
                echo "Hit enter for menu"
            else
                echo "broke"
            fi
        elif [[ $floor == 3 ]]; then
           AttackWeapons
           echo "Here are a list of knives 
           1: "${atkweaponshop[0]}"
           2: "${atkweaponshop[1]}"
           3: "${atkweaponshop[2]}"
           that I have availble for you now thug lucious"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${atkweaponshop[0]}" || $sold == "${atkweaponshop[1]}" || $sold == "${atkweaponshop[2]}" || $sold == "machete" || $sold == 3 || $sold == "hunting" || $sold == "butterfly" || $sold == 1 || $sold == 2  ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
        else
           echo "You do not yet have the bag, no cap, come back when you a G"
        fi
       ;;
       Purchase_a_Gun)
         if [[ $floor == 1 ]]; then
           MagicWeapons 
           echo "Here are a list of pieces 
           1: "${magweaponshop[0]}"
           that I have availble for you now young thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${magweaponshop[0]}" || $sold == "desert_eagle" || $sold == "desert eagle" || $sold == "Desert Eagle" || $sold == 1 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
         elif [[ $floor == 2 ]]; then
           MagicWeapons 
           echo "Here are a list of shooters 
           1: "${magweaponshop[0]}"
           2: "${magweaponshop[1]}"
           that I have availble for you now thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${magweaponshop[0]}" || $sold == "${magweaponshop[1]}" || $sold == "${magweaponshop[2]}" || $sold == "desert_eagle" || $sold == "desert eagle" || $sold == "Desert Eagle" || $sold == 1 || $sold == "Uzi" || $sold == "uzi" || $sold == 2 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
         elif [[ $floor == 3 ]]; then
            MagicWeapons
            echo "Here are a list of heaters 
            1: "${magweaponshop[0]}"
            2: "${magweaponshop[1]}"
            3: "${magweaponshop[2]}"
            that I have availble for you now thug lucious"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[  $sold == "${magweaponshop[0]}" || $sold == "${magweaponshop[1]}" || $sold == "${magweaponshop[2]}" || $sold == "desert_eagle" || $sold == "desert eagle" || $sold == "Desert Eagle" || $sold == 1 || $sold == "Uzi" || $sold == "uzi" || $sold == 2 || $sold == "${magweaponshop[2]}" || $sold == "shotgun" || $sold == 3 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
         else
           echo "You best got glizzys in that mouth then the gat, come back when you step up like a G"
         fi
       ;;
       Purchase_a_new_Basketball)
         if [[ $floor == 1 ]]; then
           BasketballWeapons
           echo "Here are a list of bricks 
           1: "${ballweaponshop[0]}" 
           that I have availble for you now young thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then 
                if [[ $sold == "${ballweaponshop[0]}" || $sold == "inflated_basketball" || $sold == "Inflated Basketball" || $sold == "inflated basketball" || $sold == 1 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
         elif [[ $floor == 2 ]]; then
           BasketballWeapons
           echo "Here are a list of rocks 
           1: "${ballweaponshop[0]}"
           2: "${ballweaponshop[1]}"
           that I have availble for you now thug"
            echo "What do you want to purchase?"
            read sold 
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${ballweaponshop[0]}" || $sold == "inflated_basketball" || $sold == "Inflated Basketball" || $sold == "inflated basketball" || $sold == 1 || $sold == "${ballweaponshop[1]}" || $sold == "Regulation Basketball" || $sold == "regulation_basketball" || $sold == "regulation basketball" || $sold == 2 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "you broke"
            fi
         elif [[ $floor == 3 ]]; then
           BasketballWeapons
           echo "Here are a list of b-balls 
           1: "${ballweaponshop[0]}"
           2: "${ballweaponshop[1]}"
           3: "${ballweaponshop[2]}"
           that I have availble for you now thug lucious"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then 
                if [[ $sold == "${ballweaponshop[0]}" || $sold == "inflated_basketball" || $sold == "Inflated Basketball" || $sold == "inflated basketball" || $sold == 1 || $sold == "${ballweaponshop[1]}" || $sold == "Regulation Basketball" || $sold == "regulation_basketball" || $sold == "regulation basketball" || $sold == 2 || $sold == "All-Star Signed Basketball" || $sold == "all-star signed basketball" || $sold == "all-star_signed_basketball" || $sold == 3 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "you broke"
            fi
         else
           echo "Don't come in here trying to disrespect me when you haven't even beat the first boss, come back when you can beat Dennis Rodman"
         fi
       ;;
       Purchase_a_better_Scare)
         if [[ $floor == 1 ]]; then
           ScareWeapons 
           echo "Here are a list of acts 
           1: "${scareweaponshop[0]}"
           that I have availble for you now young thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${scareweaponshop[0]}" || $sold == "Flickering_Lights" || $sold == "flickering lights" || $sold == 1 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "you broke"
            fi
         elif [[ $floor == 2 ]]; then
           ScareWeapons 
           echo "Here are a list of tricks 
           1: "${scareweaponshop[0]}"
           2: "${scareweaponshop[1]}"
           that I have availble for you now thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${scareweaponshop[0]}" || $sold == "Flickering_Lights" || $sold == "flickering lights" || $sold == 1 || $sold == "${scareweaponshop[1]}" || $sold == "Spooky Noise" || $sold == "spooky_noise" || $sold == "spooky noise" || $sold == 2 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "you broke"
            fi
         elif [[ $floor == 3 ]]; then
           ScareWeapons
           echo "Here are a list of moves 
           1: "${scareweaponshop[0]}"
           2: "${scareweaponshop[1]}"
           3: "${scareweaponshop[2]}"
           that I have availble for you now thug lucious"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then
                if [[ $sold == "${scareweaponshop[0]}" || $sold == "Flickering_Lights" || $sold == "flickering lights" || $sold == 1 || $sold == "${scareweaponshop[1]}" || $sold == "Spooky Noise" || $sold == "spooky_noise" || $sold == "spooky noise" || $sold == 2 || $sold == "${scareweaponshop[2]}" || $sold == "possession" || $sold == 3 ]]; then
                PurchaseWeapon
                else 
                echo "I don't got that here"
                fi
            else
                echo "You broke"
            fi
         else
           echo "Ol stupid ass can't even scare an old grandma, get out of here youngin"
         fi
       ;;
       Purchase_a_new_armor)
         if [[ $floor == 1 ]]; then
           Armors
           echo "Here are a list of gear 
           1: "${armorshop[0]}"
           that I have availble for you now young thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then  
                if [[ $sold == "${armorshop[0]}" || $sold == "jeans" || $sold == 1 ]]; then
                PurchaseArmor
                else 
                echo "I don't got that here"
                fi
            else
                echo "you broke"
            fi
         elif [[ $floor == 2 ]]; then
           Armors  
           echo "Here are a list of apparel 
           1: "${armorshop[0]}"
           2: "${armorshop[1]}"
           that I have availble for you now thug"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then 
                if [[ $sold == "${armorshop[0]}" || $sold == "jeans" || $sold == 1 || $sold == "${armorshop[1]}" || $sold == "hoodie" || $sold == 2 ]]; then
                PurchaseArmor
                else 
                echo "I don't got that here"
                fi
            else
                echo "broke"
            fi
         elif [[ $floor == 3 ]]; then
           Armors 
            echo "Here are a list of drip 
            1: "${armorshop[0]}"
            2: "${armorshop[1]}"
            3: "${armorshop[2]}" 
            that I have availble for you now thug lucious"
            echo "What do you want to purchase?"
            read sold
            Pocket
            if [[ $coin -gt 0 ]]; then 
                if [[ $sold == "${armorshop[0]}" || $sold == "jeans" || $sold == 1 || $sold == "${armorshop[1]}" || $sold == "hoodie" || $sold == 2 || $sold == "${armorshop[2]}" || $sold == "Dope Bling" || $sold == "dope bling" || $sold == 3 ]]; then
                PurchaseArmor
                else 
                sleep 0.5
                echo "I don't got that here"
                sleep 0.5
                fi
            else
                echo "broke"
            fi
         else
          sleep 0.5
           echo "Dawg, you ain't even got a dollar for me to hold, better get out of here before I make you run your pockets"
           sleep 0.5
         fi
       ;;
       Leave)
         if [[ $lvl == 1 ]]; then
          sleep 0.5
           echo "Little homie, its time to get back to adventuring, good luck, and don't let the streets get you"
         elif [[ $lvl == 2 ]]; then
          sleep 0.5
           echo "Keep moving up in the world Jabronie, good luck, and keep running ops on the block"
         elif [[ $lvl == 3 ]]; then
          sleep 0.5
           echo "Damn moving that big money, I like it, don't forget me when you run the streets"
         elif [[ $lvl == 4 ]]; then
          sleep 0.5
           echo "King of the streets, keep moving them racks, O.G"
         else
          sleep 0.5
           echo "You done bossed up, at least you never forgot me"
         fi
         sleep 1.5
         echo "You have left the shopkeeper and keep on hustlin'"
         break 2
       ;;
    esac
   done
 done
     }



####################### Purchasing Items/Item drops in the future ############################

PurchaseWeapon()
{
    if [[ $floor == 1 ]]; then
    printf "This item cost 50 coins \n do you wish to purchase? (y/n)"
    read paid
        if [[ $paid == "y" && $coin -gt 50 ]]; then
          sleep 1
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        sleep 1
        coin=$(( $coin - 50 ))
        printf "You now have equipped weapon $weapon\nYou have $coin bills left\n"
        elif [[ $paid == "y" && $coin < 50 ]]; then 
          sleep 0.5
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 50 ]]; then
          sleep 0.5
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 50 ]]; then
          sleep 0.5
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\nHAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
          sleep 0.2
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    elif [[ $floor == 2 ]]; then
        printf "This item cost 70 coins  do you wish to purchase? (y/n)\n"
    read paid
        if [[ $paid == "y" && $coin -gt 70 ]]; then
        coin=$(( $coin - 70 ))
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        printf "You now have equipped weapon $weapon\nYou have $coin bills left\n"
        elif [[ $paid == "y" && $coin < 70 ]]; then 
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 70 ]]; then
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 70 ]]; then
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\n HAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    elif [[ $floor == 3 ]]; then
        printf "This item cost 100 coins \n do you wish to purchase? (y/n)\n"
    read paid
        if [[ $paid == "y" && $coin -gt 100 ]]; then
        coin=$(( $coin - 100 ))
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        printf "You now have equipped weapon $weapon\nYou have $coin bills left\n"
        elif [[ $paid == "y" && $coin < 100 ]]; then 
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 100 ]]; then
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 100 ]]; then
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\n HAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    else
        echo "Why are you here? You shouldn't be here"
        echo "They are coming"
    fi
}

PurchaseArmor()
{
if [[ $floor == 1 ]]; then
    printf "This item cost 50 coins \n do you wish to purchase? (y/n)\n"
    read paid
        if [[ $paid == "y" && $coin -gt 50 ]]; then
        coin=$(( $coin - 50 ))
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        printf "You now have equipped weapon $weapon\nYou have $coin bills left\n"
        elif [[ $paid == "y" && $coin < 50 ]]; then 
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 50 ]]; then
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 50 ]]; then
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\n HAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    elif [[ $floor == 2 ]]; then
        printf "This item cost 70 coins \n do you wish to purchase? (y/n)\n"
    read paid
        if [[ $paid == "y" && $coin -gt 70 ]]; then
        coin=$(( $coin - 70 ))
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        printf "You now have equipped weapon $weapon\nYou have $coin bills left\n"
        elif [[ $paid == "y" && $coin < 70 ]]; then 
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 70 ]]; then
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 70 ]]; then
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\n HAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    elif [[ $floor == 3 ]]; then
        printf "This item cost 100 coins \n do you wish to purchase? (y/n)\n"
    read paid
        if [[ $paid == "y" && $coin -gt 100 ]]; then
        coin=$(( $coin - 100 ))
        printf "You just bought a $sold \nCongratulation\nThanks for the bills\n"
        weapon=$sold
        printf "You now have equipped weapon $weapon\nYou have $coin left\n"
        elif [[ $paid == "y" && $coin < 100 ]]; then 
        printf "You is broke Jabronie! \nGo running to your Bae maybe they can spot you\n"
        elif [[ $paid == "n" && $coin -gt 100 ]]; then
        printf "You holding out on me??\nIt be like that huh?\nI hope you get capped then.\nNaw I'm playing but for real come back through.\n"
        elif [[ $paid == "n" && $coin < 100 ]]; then
        printf "HAHAHAHAHAHAHAHA YOU BROKE!!!!\nHAHAHAHAHAHAHAHAHAHAHAHAHAHA!!!!\nYOU SO POOR, WHEN A HOMELESS PERSONS ASKS FOR MONEY, HE GIVES YOU CHANGE!\n HAHAHAHAHAHAAHAHAHAHAHA!\n"
        else
        echo "You high!?"
        sleep 1.3
        echo "What you on because you better give me some"
        sleep 1 
        fi
    else
        echo "Why are you here? You shouldn't be here"
        echo "They are coming"
    fi
}


##############################################################################################
################################### Movement Through the block ###############################
##############################################################################################

#################################### Movement #############################################
MOVE() {
    Walk=$(($RANDOM%4+1))
    Blocks=$(($floorspace - $Walk))
    floorspace=$Blocks
    Encounter
    ((inspectblock--))
}

################################## Roaming through the blocks ##############################

TrueRoaming() {
    adventure="What do you wanna do?"
    while true; do
        select adventuremenu in Walk_the_block Run_ops_on_block Holla; do
            case $adventuremenu in
                Walk_the_block)
                    MOVE
                    if [[ $Blocks > 0 ]];then
                        if (($Walk == 1));then
                            echo "You have walked a single block, got $Blocks to go"
                        elif (($Walk > 1 ));then 
                            echo "You have walked $Walk blocks, got $Blocks to go"
                        fi
                    elif [[  $Blocks -le 0 ]];then
                        echo "You have reach the end of the hood."
                        sleep 0.5
                        echo "Looks like $boss is here."
                        sleep 0.5
                        echo "He wants to fight. You've been working his turf and he's mad"
                        BossFight
                        break 2
                    fi
                ;;
                Run_ops_on_block)
                    inspections=$(( $triggers + 2 ))
                    if [[ $inspectblock < $inspections ]]; then
                      echo "........."
                      sleep 0.4
                      Encounter
                      sleep 0.4
                      echo "........."
                      ((inspectblock++))
                      echo "You've run ops on this block"
                  else
                    sleep 0.5
                    echo "You've beat the block down get moving"
                    sleep 0.3
                    echo "You really need to stop picking on people"
                    sleep 0.3
                    fi        

                ;;
                Holla)
                    echo "You whip out your phone"
                    sleep 0.3
                    echo "You look at your contact list"
                    sleep 0.3
                    echo "Who you going to call?
                    Bae
                    Shopkeeper
                    Homie"
                    read calling
                    if [[ $calling == "Bae" || $calling == "bae" || $calling == 1 ]]; then
                        echo "You ring up your Bae"
                      sleep 1
                      baehead=$(( $RANDOM % 4 ))
                        if [[ $baehead == 0 ]]; then
                            Pocket
                            if [[ $coin > 0 ]]; then
                                coin=$(( $coin - $(( $RANDOM % 20+1 )) ))
                                sleep 0.5
                                echo "you paid for an uber"
                                Bae
                            elif [[ $coin -le 0 ]]; then
                            sleep 0.5
                            echo "You can't afford the uber"
                            fi
                        else
                            sleep 0.5
                            echo "Bae is busy, seems like she can't come through"
                            echo "You leave a voicemail, ....simp...."
                        fi
                    elif [[ $calling == "Shopkeeper" || $calling == "shopkeeper" || $calling == 2 ]]; then
                      Merchant
                    elif [[ $calling == "Homie" || $calling == "homie" || $calling == 3 ]]; then
                      HHomie
                    fi

                ;;
            esac
        done
    done


}

Floorchange()
{
    clear
    Floorlevel
    Floorboss
    echo "You own this hood"
    sleep 1.3
    echo "You have cleared out the competition"
    sleep 1.3
    echo "Now its time to take over more hoods to make your empire"
    echo " "
    inspectblock=0
}


################# Holla functions for the everyone espcially the homie  ##################

## This is for the Homie counter for the secret boss fights

homiecounter=0


HHomie()
{
    if [[ $homiecounter == 0 ]]; then
                    echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "You get more encounters if you run ops on the block closer to the end"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 1 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "Be careful of the old hag, I hate her, you keep messing with her you might get some hands"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 2 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I heard some rumors about your Bae, she got a pimp and she might get in trouble if you keep getting it for free."
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 3 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "You can go over in hp if you hook up with the ladies, is it morally wrong? Maybe but that's on you."
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 4 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll be honest for this one, magic stat does nothing in this game. Sorry about that homie."
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 5 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I got your weather for you location"
                      curl wttr.in
                      echo "If it doesn't work it because you got a firewall and thats on you."
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 6 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "Tissue"
                      sleep 1
                      echo "If you don't know how to do it let me tissue"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 7 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "July"
                      sleep 1
                      echo "I don't trust you because July all the time"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 8 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "Wheelchair"
                      sleep 1
                      echo "There's only one donut left so wheelchair"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 9 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "Juicy"
                      sleep 1
                      echo "Tell me if Juicy the cops"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 10 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "Bodywash"
                      sleep 1
                      echo "I wanted to go to the club tonight but no Bodywash my kids"
                      sleep 1
                      echo "Btw just leting you know some pimp named slickback is looking for you"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 11 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I'll teach you the spanish word of the day"
                      sleep 1
                      echo "Mushroom"
                      sleep 1
                      echo "When all the family get in the car there is not Mushroom left."
                      sleep 1
                      echo "Watch out for the old hag she's a crazy old thot she packing and she in some kind of way."
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                    elif [[ $homiecounter == 12 ]]; then
                     echo "You call your homie on the phone"
                      sleep 1
                      echo "They roll up on their bike"
                      sleep 1
                      echo "I'm here to tell you secrets to this game"
                      sleep 1
                      echo "I gotta go but keep going through and you got this."
                      sleep 1
                      echo "Don't call me too many times."
                      sleep 1
                      echo "If you call me more than 20 times I'll have to take your place and be a street king"
                      sleep 1
                      echo "Have a good day"
                      sleep 1
                      echo "He rides away on his bike"
                  elif [[ $homiecounter == 19 ]]; then
                    echo "Look we homies"
                    sleep 1
                    echo "I've called in a couple favors"
                    sleep 1
                    echo "...if you drop a couple bodies..."
                    sleep 1
                    echo "you'll be getting some nice drops"
                    sleep 1
                    echo "now stop bugging me else I'm going to have to come to you and show you the business"
                    sleep 1
                    echo "He sounded upset, but at least you got better drop chances"
                    sleep 1
                    echo "I wonder what would happen if you bug him one more time?"
                    sleep 1
                    echo "Naw, you don't wanna get clapped by the Homie do you?"
                    elif [[ $homiecounter -ge 20 ]]; then
                        echo "Yo dog what did I say about call me so many times!"
                        sleep 1
                        echo "I'm balls deep and you interrupting."
                        sleep 1
                        echo "I'mma see you later for sure."
                        sleep
                        echo "He hung up"
                    else
                        echo "Goes to voicemail"
                        sleep 1
                        echo "Guess he's busy"
                        sleep 1
                        echo "Maybe don't bug him too much?"
                        sleep 1
                        echo "Or do? ....I'm just the guy who coded this for a nice surprise...."
                    fi




((homiecounter++))
}

######################## Player starting class & stats #############################

startingclass() 
{
  while true; do
    select classchoice in Homie Baller Gangster Ghost; do
    case $classchoice in
        
        Homie)
            type="Homie"
            lvl=1
            maxhp=15
            attack=10
            magic=10
            speed=10
            weapon="Shiv"
            armor=0
            coin=0
            xp=0
            hp=$maxhp
            postbattlehp=$maxhp
            break 2
        ;;
        Baller)
            type="Baller"
            lvl=1
            maxhp=20
            attack=10
            magic=5
            speed=8
            weapon="DeflatedBasketball"
            armor=0
            coin=0
            xp=0
            hp=$maxhp
            postbattlehp=$maxhp
            break 2
        ;;
        Gangster)
            type="Gangster"
            lvl=1
            maxhp=10
            attack=12
            magic=15
            speed=12
            weapon="Glock"
            armor=0
            coin=0
            xp=0
            hp=$maxhp
            postbattlehp=$maxhp
            break 2
        ;;
        Ghost)
            type="Ghost"
            lvl=1
            maxhp=50
            attack=100
            magic=2
            speed=100
            weapon="Haunt"
            armor=100
            coin=0
            xp=0
            hp=$maxhp
            postbattlehp=$maxhp
            break 2
        ;;
    esac
  done
  done
}

####################################### Attacking and battle ##################################

BAssault(){
  hit=$speed
  swing=$(( $RANDOM%20 +1 ))
  if [[ $(( $swing + $bossspd )) -ge $hit ]]; then
    echo "$boss attacks"
    if [[ $swing == 20 ]]; then
      postbattlehp=$(( $postbattlehp - $(($(( $sbossatk * 2 )) - $armor ))))
      printf "The $boss landed a critical hit \n You take $(($(( $bossatk * 2 )) - $armor )) damage \n You have $postbattlehp hp remaining\n"
    else
    postbattlehp=$(( $postbattlehp - $(($bossatk - $armor ))))
    printf "You got hit for $bossatk damage \nYou have $postbattlehp hp remainaing\n"
    fi
  elif [[ $(( $swing + $floor )) -lt $hit ]]; then
    printf "The $boss attacks \nThe $boss missed\n"
  fi
    
}

SBAssault(){
  hit=$speed
  swing=$(( $RANDOM%20 +5 ))
  if [[ $(( $swing + $bossspd )) -ge $hit ]]; then
    echo "The $sboss attacks"
    if [[ $swing == 20 ]]; then
      postbattlehp=$(( $postbattlehp - $(($(( $bossatk * 3 )) - $armor ))))
      printf "The $sboss landed a critical hit \n You take $(($(( $sbossatk * 2 )) - $armor )) damage \n You have $postbattlehp hp remaining\n"
    else
    postbattlehp=$(( $postbattlehp - $(($sbossatk - $armor ))))
    printf "You got hit for $sbossatk damage \nYou have $postbattlehp hp remainaing\n"
    fi
  elif [[ $(( $swing + $floor )) -lt $hit ]]; then
    printf "The $sboss attacks \nThe $sboss missed\n"
  fi
    
}

################################### GAMEPLAY ##################################################

Gameplay()
{
  Intro
    while true; do
        if [[ $hp > 0  && $floor -ne 4 ]]; then
            TrueRoaming
            Floorchange
        elif  [[ $floor == 4 ]]; then
            if [[ $homiecounter -ge 20 ]]; then
                BossHomie
                if [[ $sbosshp1 == 0 && $sbosshp2 == 0 && $sbosshp3 == 0 ]]; then 
                    sleep 4
                    clear
                    echo '...'
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "You have completed your empire"
                    sleep 1
                    echo "You own the hood"
                    sleep 1
                    echo "You are the street king"
                    sleep 1
                    echo "You've slain all rivals, nothing stands in your way, but its lonely at the top"
                    sleep 1
                    echo "Congratulations"
                    sleep 1
                    echo "The world is yours"
                    #curl -L http://bit.ly/10hA8iC | bash
                    break
                else
                    sleep 4
                    clear
                    echo '...'
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "You have completed your empire"
                    sleep 1
                    echo "You run a pretty big strech of turf"
                    sleep 1
                    echo "You are a street boss"
                    sleep 1
                    echo "Congratulations"
                    sleep 1
                    echo "You still got some street rivals so you'll have to try harder next time..."
                    break
                fi
            else
                   sleep 4
                    clear
                    echo '...'
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "..."
                    sleep 1
                    echo "You have completed your empire"
                    sleep 1
                    echo "You run a pretty big strech of turf"
                    sleep 1
                    echo "You are a street boss"
                    sleep 1
                    echo "Congratulations"
                    sleep 1
                    echo "You still got some street rivals so you'll have to try harder next time..."
                    break
            fi
        fi
    done
}

###############################################################################################

#Taking the user data and having the intro ghost to guess the user name

NameCapture()
{
  player=$(finger $USER | grep Name | cut -d " " -f6)
}



###############################################################################################

###############################################################################################
###################################### Intro ##################################################
###############################################################################################

Intro()
{
  clear
  # trap '' 2
  echo "Welcome Jabronie, it would appear you lack bitches, but no worries,"
  sleep 1
  echo "I got you little homie, we'll get you straight."
  sleep 1
  echo "First what's you name wait let me guess?"
  sleep 1
  NameCapture
  echo "$player is that right? (y/n)"
  read name
  sleep 2
  if [[ $name == "n" || $name == "no" || $name == "N" || $name == "No" ]]; then
    echo "Awww dang well I guess no one knows your name"
    sleep 1
    echo "What's your name then?"
    read name
    sleep 1
    echo "Thats a name for sure, $name, well lets get you started"
    sleep 1
    echo "Now $name you need to let me know what your aspiration of a career are from this very detailed list"
    startingclass 
    sleep 1.25
    echo "You have chosen $type, a good choice you will start with: 
HP:$hp 
Attack:$attack 
Magic:$magic 
Speed:$speed 
Weapon:$weapon"
    sleep 3
    echo "$name, Your adventure will begin shortly, I'll be watching over you as you climb these streets and make a name for yourself"
    BossCheck
    Floorboss
    sleep 0.75
    echo "You arrive at the streets, this is where true hustlers are made and thrive"
    sleep 0.5
    echo "You find yourself in a trailerpark with $floorspace blocks, time to make your rounds"
  elif [[ $name == "y" || $name == "Y" || $name == "Yes" || $name == "yes" ]]; then
    name=$player
    echo "I thought so see, now you gotta make your name known."
    sleep 1
    echo "Now $player you need to let me know what your aspiration of a career are from this very detailed list"
    startingclass 
    sleep 1.25
    echo "You have chosen $type, a good choice you will start with HP:$hp, Attack:$attack, Magic:$magic, Speed:$speed and Weapon:$weapon"
    sleep 1
    echo "$name, Your adventure will begin shortly, I'll be watching over you as you climb these streets and make a name for yourself"
    BossCheck
    Floorboss
    sleep 0.75
    echo "You arrive at the streets, this is where true hustlers are made and thrive"
    sleep 0.5
    echo "You find yourself in a neighborhood with $floorspace blocks, time to make your rounds"
  else
    echo "What are you doing here?"
  fi
  # trap 2
}
Gameplay