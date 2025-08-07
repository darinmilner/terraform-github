# Portfolio

## About Me

<img src="${avatar}" style="width 10%; height: auto;">

Hi.  I am ${name} a devops developer.  Check out some of my projects!

## Projects 

| Project Name | Web Page               | Link                      |
|--------------|------------------------|---------------------------|
%{for repo_key, repo_value in repos ~}
| ${repo_key}  | ${ repo_value.page_url != "no page" ? "[Webpage](${repo_value.page_url})" : "no page" }  | [Github](${repo_value.clone_url})       |
%{ endfor ~}

${date} ${name}