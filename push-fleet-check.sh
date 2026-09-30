#!/usr/bin/env bash
# Run this on your own machine, from the folder where you've unzipped fleet-check.zip
# (so that a "fleet-check" folder sits next to this script), NOT in the Claude sandbox.
#
# What it does:
#   1. Creates a new GitHub repo called "norovari-fleet-check" (private by default)
#   2. Pushes the fleet-check files into it
#   3. Prints the repo URL to import into Vercel
#
# Requirements (check these first):
#   - git installed and configured (git config --global user.name / user.email)
#   - GitHub CLI installed and logged in: https://cli.github.com/  then run `gh auth login`
#     (If you'd rather not install gh, skip to the "Manual alternative" block at the bottom.)

set -e

REPO_NAME="norovari-fleet-check"

if [ ! -d "fleet-check" ]; then
  echo "Error: run this script from the folder containing the 'fleet-check' directory."
  exit 1
fi

cd fleet-check

git init -b main
git add .
git commit -m "Fleet Risk Check: initial commit"

# Creates the GitHub repo and pushes in one step (requires gh CLI, logged in)
gh repo create "$REPO_NAME" --private --source=. --remote=origin --push

echo ""
echo "Done. Repo pushed to:"
gh repo view --json url -q .url
echo ""
echo "Next: go to vercel.com -> Add New Project -> Import that repo."
echo "Then in Settings -> Environment Variables, add SHEET_WEBHOOK_URL before testing."

# ---------------------------------------------------------------------------
# Manual alternative (no gh CLI): create an empty repo yourself at
# https://github.com/new (name it norovari-fleet-check, do NOT initialize
# it with a README), then run:
#
#   cd fleet-check
#   git init -b main
#   git add .
#   git commit -m "Fleet Risk Check: initial commit"
#   git remote add origin https://github.com/<your-username>/norovari-fleet-check.git
#   git push -u origin main
# ---------------------------------------------------------------------------
