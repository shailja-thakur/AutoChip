// The input a, b, c, d, e are boolean signals. 
The output out is a 25-bit vector.

The module computes the bitwise exclusive-or of the  25-bit vector ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} } and the 25-bit vector {5{a,b,c,d,e}}. The first vector consists of 25 bits with value 1 if the corresponding input signal is 0, and consists of 25 bits with value 0 if the corresponding input signal is 1. The second vector consists of 25 bits with value 1 if the corresponding input signal is 1, and consists of 25 bits with value 0 if the corresponding input signal is 0.



module top_module (
	input a,
	input b,
	input c,
	input d,
	input e,
	output [24:0] out
);
