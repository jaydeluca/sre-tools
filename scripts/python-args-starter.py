#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Example usage: python3 python-args-starter.py --input "test input" --file test.txt

import argparse


parser = argparse.ArgumentParser(description='Script')
parser.add_argument("-f", "--file",
                    help="file input")
parser.add_argument("-i", "--input",
                    help="input data")
args = parser.parse_args()


def main():
    if args.file:
        print(f"File input: {args.file}")

    if args.input:
        print(f"Input: {args.input}")

if __name__ == '__main__':
    main()