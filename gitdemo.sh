#! /bin/bash -x

clear
cd ~/Public/
mkdir gitdemo
cd gitdemo
git init .
ls -la

read -p " ** content empty repository, lets make .gitignore." 
clear
cp ~/Documents/Presentations/GIT/.gitignore .
less .gitignore
clear
ls -la  .git
read -p " ** content of git directory, lets see config." 
less .git/config
git branch

read -p " ** no master yet, so lets make one"
clear
git add --all
git commit -m "Starting" 
git status
git log --oneline -5
git branch release
git branch development 
git checkout development
git branch
 
read -p " ** Start of NF" 
clear
git branch NF
git checkout NF
mkdir NF
echo "Start of New Feature"  >> README.md
git add --all
git commit -m "NF: Start of New Feature"
git status

read -p "Start of P1 " 
clear
git branch P1
git checkout  P1
mkdir P1
echo " ** Start of P1" >> README.md
git add --all
git commit -m "P1:  start of P1" 
git status

read -p " ** lets start with project P1" 
clear
git checkout P1
count=1
while [ $count -lt 10 ] 
 do touch P1/P1_file.$count 
 ((count++))
 done
git add --all
git commit -m "P1: Created files" 
git status

read -p " ** now we have one commit with a number of files" 
clear
count=1
while [ $count -lt 10 ] 
 do echo "Hi there !!" >> P1/P1_file.$count 
 ((count++))
done
git add --all
git commit -m "P1: filing the files  " 
git status

read -p " ** in the mean time New Feature sprint has started." 
clear
git checkout NF
count=1
while [ $count -lt 20 ] 
 do echo "Sweating already" >> NF/NF_file.$count 
 ((count++))
done
git add --all
git commit -m "NF: first files NF" 
git status

read -p " ** Lets see where we are " 
clear
git log --graph 

read -p " ** finishing P1"
clear
git checkout development
git merge P1
git branch -d P1
git branch

read -p " ** Lets see where we are " 
clear
git log --graph 

echo  work continues on NF
read -p " **  We said you cannot commit to much ,  so we do it for every file " 
clear
git checkout NF
count=15 
while [ $count -lt 30 ] 
 do echo "Some more work done" >> NF/NF_file.$count 
 git add --all 
 git commit -m "NF: commit file NF_file.$count" 
 (( count++ )) 
done
git status

read -p " ** Lets prepare a release project P1"
clear
git checkout release
git merge development
read -p " ** set a tag " 
git tag "Release_v1.0" 
git tag
read -p
clear


read -p " ** Lets do a hotfix"
clear
git branch HF
git checkout HF
count=5 
while [ $count -lt 10 ] 
 do 
  echo "Some HOTFIX  work done" >> P1/P1_file.$count
  git add --all
  git commit -m "HF: commit file P1_file.$count"
  ((count++))
done
git status
echo "HF:  done some fixes" >> README.md
git add --all
git commit -m "HF: finished a hot fix" 
git status
git checkout development
git merge HF
git branch -d HF


read -p " ** Lets prepare a release hot fix "
clear
git checkout release
git merge development
read -p " ** set a tag"
git tag "Release_v1.1" 
git tag
read -p
clear

read -p " **  Now we start second project  P2 "
clear
git branch P2
git checkout P2
mkdir P2
echo "starting P2 " >> README.md
git add --all
git commit -m "P2: started" 
git status

count=1 
while [ $count -lt 10 ] 
 do 
  echo "Some new  work done" >> P2/P2_file.$count
  git add --all
  git commit -m "P2: commit file P2_file.$count"
  ((count++))
done

read -p " ** Lets do a less happy flow" 
clear
git status
git diff
echo "let's see what happens "  >> P2/P2_file.7
git diff
git add --all
git commit -m "P2: Done for now" 
git status

read -p " ** Lets see where we are " 
clear
git log --graph 
# git branch -d P2


read -p " ** last usage of NF" 
clear
git checkout NF
count=30
while [ $count -lt 60 ] 
 do 
  echo "pff almost there" >> NF/NF_file.$count 
  git add --all
  git commit -m "NF: commit file NF_file.$count"
 ((count++))
done
git status
git add --all
git commit -m "NF: last files NF"  
git status 
 
read -p " ** Lets see where we are " 
clear
git log --graph 

read -p " **  now finish P2 " 
clear
git checkout development
git merge P2
git branch -d P2
git checkout release
git merge development
read -p " ** lets set a tag" 
git tag "Release_v2.0"
git tag

read -p " ** Lets see where we are " 
clear
git log --graph 

read -p " ** Let's finish the new feature branch" 
clear
git checkout NF
echo "NF: finished new features" >> README.md
git add --all
git commit -m "NF:  finishing this, finally....." 
git status

read -p " ** lets release the last part " 
git checkout development
git status
read -p "check development status" 
git merge NF
git branch -d NF
git checkout release
git merge development
read -p " ** lets set a tag" 
git tag "Release_v3.0" 
git tag

read -p " ** Lets see where we are " 
clear
git log --graph






