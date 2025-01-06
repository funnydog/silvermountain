# The Mystery of Silver Mountain

The Mystery of Silver Mountain is a textual adventure written in BASIC
language taken from the book "The Mystery of Silver Mountain" by
Usborne.

To complete the adventure you need the illustrations of the book
because the game lacks any form of description, so there is no way to
know what to examine in a given location.

Fortunately the book is available to download from [Usborne
Publishing](https://usborne.com/gb/books/computer-and-coding-books) or
[Archive.org](https://web.archive.org/web/20200919224315/https://usborne.com/browse-books/features/computer-and-coding-books/).

## Instructions

To run the program you need a suitable basic interpreter like GW-Basic
or BWBasic.

To run the program execute the following command:

   ```
   $ bwbasic silver.bas
   ```

## Port to MSX Basic

I just added some initial instructions to set the type of the
variables, the width of the screen and to turn off the keys.

Also I removed the LTRIM$() function since it's not supported.

Tested with the openmsx emulating a Philips VG-8235 machine.

## Port to Common Lisp

A port to Common Lisp is also available.

To achieve such goal I de-obfuscated the encoded strings and
mapped the indices to meaningful symbols.

Therefore reading the lisp code give significant hints to solve the
adventure.

Please look at the file insights.md for more information.

The port has been tested successfully with SBCL.

## Changes made to the original

1. Fixed a bug in the pagination subroutine at line 4830.
2. Print the directions through pagination and not directly.
3. Convert the input to upper case at line 4900.
4. Use the RESTORE instruction to skip useless loops.
5. Trim the strings when computing the variable HB.
6. Don't exit after saving.

## Notes

The original program works wonderfully in modern computers but on the
old microcomputers it was painfully slow: some microcomputers had slow
BASIC interpreters.

For example the Microsoft BASIC interpreter on MSX computers was
really slow with loops, while the interpreter of the BBC Micro was way
faster (at least by looking at some videos on the internet).
