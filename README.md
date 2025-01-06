# The Mystery of the Silver Mountain

The Mystery of the Silver Mountain is a textual adventure written in Basic
Language taken from the book "The Mystery of Silver Mountain" by
Usborne.

To complete the adventure you need the illustrations of the book
because the game lacks any form of description, so there is no way to
know what to examine in a given location.

Fortunately the book is available to download from [Usborne
Publishing](https://usborne.com/gb/books/computer-and-coding-books) or
[Backup](https://web.archive.org/web/20200919224315/https://usborne.com/browse-books/features/computer-and-coding-books/).

## Instructions

To run the program you need a suitable basic interpreter like GW-Basic
or BWBasic.

To run the program execute the following command:

   ```
   $ bwbasic silver.bas
   ```

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
