#!/bin/bash
set -e

# Copy Hypr config to dotfiles
cp -r ~/.config/hypr ~/dotfiles/

# Array of playful, cutesy, and lighthearted commit messages mentioning hyprdots
commit_msgs=(
  "hyprdots :3 polished and ready."
  "hyprdots :3 now with extra shine."
  "hyprdots :3 changes applied successfully."
  "hyprdots :3 keeping it tidy."
  "hyprdots :3 all set and organized."
  "hyprdots :3 looking snazzy!"
  "hyprdots :3 a sprinkle of magic."
  "hyprdots :3 hugs not included."
  "hyprdots :3 tidy paws, tidy code."
  "hyprdots :3 update complete"
  "hyprdots :3 all cozy and comfy."
  "hyprdots :3 a dash of cuteness added!"
  "hyprdots :3 perfectly synced!"
)

# Pick a random commit message
msg=${commit_msgs[$RANDOM % ${#commit_msgs[@]}]}

cd ~/dotfiles

git add hypr
if git diff --cached --quiet; then
  echo "No changes to commit."
else
  git commit -m "$msg"
  git push
  echo "Committed with message: $msg"
fi
