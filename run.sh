#!/bin/bash
nasm boot.s -f bin -o boot.bin && echo c | bochs -f bochsrc -q
