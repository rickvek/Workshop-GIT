#! /bin/bash

clear
cd ~/Public/
set -v
mkdir gitdemo
cd gitdemo
# git init --bare .
git init  .
ls -la
set +v

Where() {
  read -p " ** Lets see where we are "
  clear
  set -v
  git log --graph
  set +v
  read -p "Press enter to continue"
  clear
}

MakeRelease() {
  git checkout release
  # we should do a rebase,  like a roll forwards. clean history.
  # !!!  only to be used localy, for uploading a clean banch.
  # git merge development
  # use --continue  after resolving merge conflicts.
  git rebase development  --verbose
}

read -p " ** content empty repository, lets make .gitignore."
clear
set -v
cp ~/Documents/Presentations/MyPresentations/GIT/.gitignore .
set +v
read -p " ** lets view the contents"
less .gitignore
clear
set -v
ls -la  .git
set +v
read -p " ** content of git directory, lets see config."
less .git/config
git branch

read -p " ** no master yet, so lets make one"
set -v
clear
git branch
git add --all
git commit -m " ##  Starting"
git status
git log --oneline
set +v
read -p "Press enter to continue"
set -v
git branch release
git branch development
git checkout development
git branch
set  +v

read -p " ** Start of NF"
clear
set -v
git branch NF
git checkout NF
mkdir NF
echo " ** Start of New Feature"  >> README.md
git add --all
git commit -m "NF: Start of New Feature"
git status
set +v

read -p " ** Start of P1 "
clear
set -v
git branch P1
git checkout  P1
mkdir P1
echo " ** Start of P1" >> README.md
git add --all
git commit -m "P1:  start of P1"
git status
set +v

read -p " ** lets start with project P1"
clear
git checkout P1
count=1
while [ $count -lt 10 ]
 do touch P1/P1_file.$count
 ((count++))
done
set -v
git add --all
git commit -m "P1: Created files"
git status
set +v

read -p " ** now we have one commit with a number of files"
clear
set -v
count=1
while [ $count -lt 10 ]
 do echo "Hi there !!" >> P1/P1_file.$count
 ((count++))
done
git add --all
git commit -m "P1: filing the files  "
git status
set +v

read -p " ** in the mean time New Feature sprint has started."
clear
set -v
git checkout NF
count=1
while [ $count -lt 20 ]
 do echo "Sweating already" >> NF/NF_file.$count
 ((count++))
done
git add --all
git commit -m "NF: first files NF"
git status
set +v

Where

read -p " ** finishing P1"
set -v
git checkout development
git merge P1
# git branch -d P1
git branch
set +v

read -p " ** Lets see where we are "
clear
set -v
git log --graph
set +v

echo  work continues on NF
read -p " **  We said you cannot commit to much ,  so we do it for every file "
clear
set -v
git checkout NF
count=15
while [ $count -lt 30 ]
 do echo "Some more work done" >> NF/NF_file.$count
 git add --all
 git commit -m "NF: commit file NF_file.$count"
 (( count++ ))
done
git status
set +v

read -p " ** Lets prepare a release project P1"
clear
set -v
MakeRelease
set +v
read -p " ** set a tag "
set -v
git tag -a 1.0 -m "Release_v1.0"
git tag
set +v
read -p
clear

Where

read -p " ** Lets do a hotfix"
set -v
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
echo " ** HF:  done some fixes" >> README.md
git add --all
git commit -m "HF: finished a hot fix"
git status
git checkout development
git merge HF
# git branch -d HF
set +v

read -p " ** Lets prepare a release hot fix "
clear
set -v
MakeRelease
set +v
read -p " ** set a tag"
clear
set -v
git tag -a 1.1 -m "Release_v1.1"
git tag
set +v
read -p
clear

Where

read -p " **  Now we start second project  P2 "
set -v
git branch P2
git checkout P2
mkdir P2
echo " ** start P2 " >> README.md
git add --all
git commit -m "P2: started"
git status
set +v
count=1
while [ $count -lt 10 ]
 do
  echo "Some new  work done" >> P2/P2_file.$count
  git add --all
  git commit -m "P2: commit file P2_file.$count"
  ((count++))
done
set -v
git status
set +v

read -p " ** Lets do a less happy flow"
clear
set -v
git status
git diff
echo "let's see what happens "  >> P2/P2_file.7
git diff
git status
git add --all
git status
git commit -m "P2: Done for now"
git status
set +v

Where

read -p " ** last usage of NF"
set -v
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
set +v

Where

read -p " **  now finish P2 "
set -v
git checkout development
git merge P2
# git branch -d P2
MakeRelease
set +v
read -p " ** lets set a tag"
clear
set -v
git tag -a 2.0 -m  "Release_v2.0"
git tag
set +v

Where

read -p " ** Let's finish the new feature branch"
set -v
git checkout NF
echo " ** NF: finished new features " >> README.md
git add --all
git commit -m "NF:  finishing this, finally....."
git status
set +v

read -p " ** lets release the last part "
set -v
git checkout development
git status
set +v
read -p "check development status"
read -p " ** lets set a tag"
set -v
git merge NF
# git branch -d NF
read -p "

        Solve merge conflict first, in other screen, then continue.

        "
MakeRelease
git tag -a 3.0 -m "Release_v3.0"
git tag
set +v

Where

echo  "  ####  THE END ###  "
