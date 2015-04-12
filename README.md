# libencode

A scheme library for bencode (of the bittorrent fame) decoding,
encoding, and validation.

## Requirements
chicken-scheme

## Compilation
make

## Installation
sudo make install

## Uninstallation
chicken-uninstall -s libencode

## Testing
make test

## Cleaning
make clean

## Example usage

### Example of bencode to s-epxression format conversion

```scheme
;;; "Converting the bencoded value into s-expression"
(require-extension libencode)
(let ((iport (open-input-string "d4:spaml1:a1:bei-1eli500eee")))
      (assert (equal?  '(("spam" . ("a" "b"))
			 (-1 . (500)))
		       (decoder iport))
	      "DICT TEST FAIL: d4:spaml1:a1:bei-1eli500eee")
      (close-input-port iport))
```

The above example shows using the bencode format to s-expression format
conversion. Malformed bencoded format will be reported as such.

The function signature is: ```scheme decoder <input-port> ```

### Example of s-expression to bencode format conversion

```scheme
(let ()
  (assert (equal?
	   "d4:spaml1:a1:bei-1eli500eee"
	   (encode '(("spam" . ("a" "b"))
		     (-1 . (500)))))
	  "DICT TEST FAIL: d4:spaml1:a1:bei-1eli500eee"))
```

The function signature is: ```scheme encode <s-expression>```

## The format (both ways bencode <-> s-expression)
|Bencode format | Generated S-expression|
| ------------	| --------------------- |
|int            | number		|
|string         | string		|
|list           | list			|
|dict           | vec of pair	|
