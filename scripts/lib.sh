#!/usr/bin/env bash
# Biblioteca compartida para bin/init, bin/sync, bin/status, bin/doctor

set -euo pipefail

andes_agent_root() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  printf '%s\n' "$dir"
}

REPOS_YAML="$(andes_agent_root)/repos.yaml"

if [[ ! -f "$REPOS_YAML" ]]; then
  echo "error: no se encontró repos.yaml en $(andes_agent_root)" >&2
  exit 1
fi

# Emite líneas TSV: name\turl\tbranch\tpath\tdescription
andes_list_repos_tsv() {
  ruby -ryaml -rjson -e '
    data = YAML.load_file(ARGV[0])
    (data["repos"] || []).each do |r|
      fields = %w[name url branch path description].map { |k| (r[k] || "").to_s.gsub(/\t/, " ") }
      puts fields.join("\t")
    end
  ' "$REPOS_YAML"
}

andes_repo_field() {
  local name="$1"
  local field="$2"
  andes_list_repos_tsv | awk -F'\t' -v n="$name" -v f="$field" '
    $1 == n {
      if (f == "name") print $1
      else if (f == "url") print $2
      else if (f == "branch") print $3
      else if (f == "path") print $4
      else if (f == "description") print $5
      exit
    }
  '
}

andes_abs_path() {
  local rel="$1"
  if [[ "$rel" = /* ]]; then
    printf '%s\n' "$rel"
  else
    printf '%s\n' "$(andes_agent_root)/$rel"
  fi
}