#!/usr/bin/env python

import argparse
import sys

from git_annex_adapter.repo import GitAnnexRepo

def tree_print(repo, path=None):
    repo = GitAnnexRepo(repo)
    repo.annex.get_file_tree()

    tree = repo.annex.get_file_tree()

    if path is not None:
        print(tree[path])
    else:
        print(set(tree))

def build_parser():
    parser = argparse.ArgumentParser(
        description='Python CLI to git-annex',
    )
    parser.add_argument('repo',
        help='Path to git annex repo'
    )
    return parser

def main(argv=None):
    parser = build_parser()
    args = parser.parse_args(argv)

    tree_print(args.repo)

    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main(sys.argv[1:]))
