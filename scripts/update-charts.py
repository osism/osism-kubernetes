#!/usr/bin/env python3
"""
Script to update chart versions in .charts.yml by fetching latest versions from artifacthub.io
"""

import yaml
import requests
import re
import sys
from typing import Dict, Optional


class CustomYAMLDumper(yaml.SafeDumper):
    """Custom YAML dumper with proper indentation for lists"""

    def increase_indent(self, flow=False, indentless=False):
        return super().increase_indent(flow, False)


def extract_chart_info_from_url(url: str) -> Optional[Dict[str, str]]:
    """Extract chart repository and name from artifacthub.io URL"""
    pattern = r"https://artifacthub\.io/packages/helm/([^/]+)/([^/]+)"
    match = re.search(pattern, url)
    if match:
        return {"repo": match.group(1), "name": match.group(2)}
    return None


def get_latest_version(repo: str, chart_name: str) -> Optional[str]:
    """Fetch latest version from artifacthub.io API"""
    api_url = f"https://artifacthub.io/api/v1/packages/helm/{repo}/{chart_name}"

    try:
        response = requests.get(api_url, timeout=10)
        response.raise_for_status()
        data = response.json()
        return data.get("version")
    except requests.exceptions.RequestException as e:
        print(f"Error fetching version for {repo}/{chart_name}: {e}")
        return None
    except ValueError as e:
        print(f"Error parsing JSON response for {repo}/{chart_name}: {e}")
        return None


def update_chart_versions(file_path: str = ".charts.yml") -> None:
    """Update chart versions in the YAML file"""
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)
    except FileNotFoundError:
        print(f"Error: File {file_path} not found")
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
        sys.exit(1)

    if "charts" not in data:
        print("Error: No 'charts' key found in YAML file")
        sys.exit(1)

    updated_count = 0

    for chart in data["charts"]:
        chart_name = chart.get("name", "Unknown")
        source_url = chart.get("source")
        current_version = chart.get("version", "Unknown")

        if not source_url:
            print(f"Skipping {chart_name}: No source URL found")
            continue

        chart_info = extract_chart_info_from_url(source_url)
        if not chart_info:
            print(f"Skipping {chart_name}: Could not parse source URL")
            continue

        print(f"Checking {chart_name} (current: {current_version})...")

        latest_version = get_latest_version(chart_info["repo"], chart_info["name"])
        if not latest_version:
            print(f"  Could not fetch latest version for {chart_name}")
            continue

        if latest_version != current_version:
            print(f"  Updating {chart_name}: {current_version} -> {latest_version}")
            chart["version"] = latest_version
            updated_count += 1
        else:
            print(f"  {chart_name} is already up to date")

    if updated_count > 0:
        try:
            with open(file_path, "w", encoding="utf-8") as f:
                f.write("---\n")  # Document start marker
                yaml.dump(
                    data,
                    f,
                    Dumper=CustomYAMLDumper,
                    default_flow_style=False,
                    sort_keys=False,
                    allow_unicode=True,
                    indent=2,
                    width=120,
                )
            print(f"\nUpdated {updated_count} chart(s) in {file_path}")
        except Exception as e:
            print(f"Error writing to file: {e}")
            sys.exit(1)
    else:
        print("\nNo charts needed updating")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Update chart versions in .charts.yml")
    parser.add_argument(
        "--file",
        "-f",
        default=".charts.yml",
        help="Path to charts YAML file (default: .charts.yml)",
    )
    parser.add_argument(
        "--dry-run",
        "-n",
        action="store_true",
        help="Show what would be updated without making changes",
    )

    args = parser.parse_args()

    if args.dry_run:
        print("DRY RUN MODE - No changes will be made")

    update_chart_versions(args.file)
