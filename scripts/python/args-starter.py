#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Example usage: python3 args-starter.py --input "test input" --file test.txt

import argparse
import os.path
from os import path
import logging

class Main(object):
    def __init__(self, args):
        if args.file:
            print(f"File input: {args.file}")

            # Parse comma separated csv
            if path.exists(args.file):
                input_file = open(args.file, 'r')
                for line in input_file:
                    (item1, item2) = line.strip().split(",")

            else:
                logging.error(f"Unable to find file {args.file}")


        if args.input:
            print(f"Input: {args.input}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Script')
    parser.add_argument("-f", "--file",
                        help="file input")
    parser.add_argument("-i", "--input",
                        help="input data")
    arguments = parser.parse_args()
    Main(arguments)