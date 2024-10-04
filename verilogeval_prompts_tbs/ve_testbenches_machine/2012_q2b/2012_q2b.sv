//  This Verilog module is a combinational logic circuit that takes in 6-bit input vector y and a single bit input w. The module then outputs two signals Y1 and Y3.   Y1 is the logical AND of the first bit of the input vector y and the single bit input w. Y3 is the logical AND of the logical OR of the second, third, fifth and sixth bits of the input vector y and the logical NOT of the single bit input w.   In other words, Y1 is true if both the first bit of the input vector y and the single bit input w are true, and Y3 is true if at least one of the second, third, fifth and sixth bits of the input vector y is true and the single bit input w is false.

module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
