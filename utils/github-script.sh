unset GITHUB_TOKEN && gh auth login -h github.com -p https -s delete_repo -w

# windows
Remove-Item Env:\GITHUB_TOKEN -ErrorAction SilentlyContinue; gh auth login -h github.com -p https -s delete_repo -w

set GITHUB_TOKEN=
gh auth login -h github.com -p https -s delete_repo -w

# delete repo
gh repo delete terraform-exam-review-63751 --yes