#!/usr/bin/env python3
import sys

def test_good():
    print("Good test")
    exit(0)


def test_bad():
    print("Bad test")
    exit(-1)


def test_empty():
    print("Empty transaction")
    exit(-2)

def main():
    """
    Main funcion
    """
    test_good()
    #test_bad()
    #test_empty()
    pass

if __name__== "__main__":
    main()
    exit(0)


#exit(0)

