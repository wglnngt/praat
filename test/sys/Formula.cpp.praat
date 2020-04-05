# File sys/Formula.cpp.praat
# Generated by test/createPraatTests.praat
# Sun Apr  5 13:16:22 2020

#
# result = x + y
#
x = 5
y = 6
result = x + y
assert result = 11

#
# result# = x + owned y#
#
result# = 5 + { 11, 13, 31 }   ; numeric vector literals are owned
assert result# = { 16, 18, 36 }

#
# result# = x + unowned y#
#
y# = { 17, -11, 29 }
result# = 30 + y#   ; numeric vector variables are not owned
assert result# = { 47, 19, 59 }

#
# Error: unequal sizes.
#
x# = { 11, 13, 17 }
y# = { 8, 90 }
asserterror When adding vectors, their numbers of elements should be equal, instead of 3 and 2.
result# = x# + y#

#
# result# = owned x# + y#
#
result# = { 11, 13, 17 } + { 44, 56, 67 }   ; owned + owned
assert result# = { 55, 69, 84 }
y# = { 3, 2, 89.5 }
result# = { 11, 13, 17 } + y#   ; owned + unowned
assert result# = { 14, 15, 106.5 }

#
# result# = unowned x# + owned y#
#
x# = { 14, -3, 6.25 }
result# = x# + { 55, 1, -89 }
assert result# = { 69, -2, -82.75 }

#
# result# = unowned x# + unowned y#
#
x# = { 14, -33, 6.25 }
y# = { -33, 17, 9 }
result# = x# + y#
assert result# = { -19, -16, 15.25 }

assert { 1, 2, 3 } + { { 1, 2 }, { 3, 4 }, { 5, 6 } } = { { 2, 3 }, { 5, 6 }, { 8, 9 } }

a# = { 1, 2, 3 }
assert a# + { { 1, 2 }, { 3, 4 }, { 5, 6 } } = { { 2, 3 }, { 5, 6 }, { 8, 9 } }

#
# result## = owned x## + y#
#
y# = { -5, 6, -19 }
result## = { { 14, -33, 6.25 }, { -33, 17, 9 } } + y#
assert result## = { { 9, -27, -12.75 }, { -38, 23, -10 } }

#
# result## = unowned x## + y#
#
x## = { { 14, -33, 6.25 }, { -33, 17, 9 } }
y# = { -5, 6, -19 }
result## = x## + y#
assert result## = { { 9, -27, -12.75 }, { -38, 23, -10 } }

#
# result = x * y
#
x = 5
y = 6
result = x * y
assert result = 30

#
# result# = x * owned y#
#
result# = 5 * { 11, 13, 31 }   ; numeric vector literals are owned
assert result# = { 55, 65, 155 }

#
# result# = x * unowned y#
#
y# = { 17, -11, 29 }
result# = 30 * y#   ; numeric vector variables are not owned
assert result# = { 510, -330, 870 }

#
# Error: unequal sizes.
#
x# = { 11, 13, 17 }
y# = { 8, 90 }
asserterror When multiplying vectors, their numbers of elements should be equal, instead of 3 and 2.
result# = x# * y#

#
# result# = owned x# * y#
#
result# = { 11, 13, 17 } * { 44, 56, 67 }   ; owned * owned
assert result# = { 484, 728, 1139 }
y# = { 3, 2, 89.5 }
result# = { 11, 13, 17 } * y#   ; owned * unowned
assert result# = { 33, 26, 1521.5 }

#
# result# = unowned x# * owned y#
#
x# = { 14, -3, 6.25 }
result# = x# * { 55, 1, -89 }
assert result# = { 770, -3, -556.25 }

#
# result# = unowned x# * unowned y#
#
x# = { 14, -33, 6.25 }
y# = { -33, 17, 9 }
result# = x# * y#
assert result# = { -462, -561, 56.25 }

assert { 1, 2, 3 } * { { 1, 2 }, { 3, 4 }, { 5, 6 } } = { { 1, 2 }, { 6, 8 }, { 15, 18 } }

a# = { 1, 2, 3 }
assert a# * { { 1, 2 }, { 3, 4 }, { 5, 6 } } = { { 1, 2 }, { 6, 8 }, { 15, 18 } }

assert { 3, 4 } ^ 3 = { 27, 64 }
assert { 3, -4 } ^ 3 = { 27, -64 }
assert { -4 } ^ 2.3 = { undefined }

a# = zero# (10)
a# ~ sum ({ 3, 4 } ^ 2)
assert sum (a#) = 250
a# ~ sum ({ col } ^ 2)
assert sum (a#) = 385

#
# The published test: the 10,000th element of the default 64-bit Mersenne Twister random sequence
# should be 9981545732273789042.
#
random_initializeWithSeedUnsafelyButPredictably (5489)
for i to 10000
	a = randomUniform (0, 1)
endfor
random_initializeSafelyAndUnpredictably ()
a *= 2 ^ 64
roundingError = a - 9981545732273789042
writeInfoLine: fixed$ (a, 0), " ", roundingError
assert roundingError <= 2048   ; actually usually zero

assert transpose## ({ { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 } }) = { { 1, 4, 7 }, { 2, 5, 8 }, { 3, 6, 9 } }

assert transpose## ({ { 1, 2, 3 }, { 4, 5, 6 } }) = { { 1, 4 }, { 2, 5 }, { 3, 6 } }

a## = { { 1, 2, 3 }, { 4, 5, 6 } }
assert transpose## (a##) = { { 1, 4 }, { 2, 5 }, { 3, 6 } }
assert transpose## (transpose## (a##)) = a##

a## = { { 4, 7, -10 }, { 16, 0, 88 } }
result# = columnSums# (a##)
assert result# = { 20, 7, 78 }

appendInfoLine: "sys/Formula.cpp.praat", " OK"
