//     the functionality of the top Verilog module is a decoder.
    if a,b,c,d == 0, the output is 0;
    if a,b,c,d == 1, the output is 0;
    if a,b,c,d == 3, the output is 1;
    if a,b,c,d == 2, the output is 1;
    if a,b,c,d == 4, the output is 1'bx;
    if a,b,c,d == 5, the output is 0;
    if a,b,c,d == 7, the output is 0;
    if a,b,c,d == 6, the output is 0;
    if a,b,c,d == c, the output is 1;
    if a,b,c,d == d, the output is 1'bx;
    if a,b,c,d == f, the output is 1;
    if a,b,c,d == e, the output is 1;
    if a,b,c,d == 8, the output is 1;
    if a,b,c,d == 9, the output is 1'bx;
    if a,b,c,d == b, the output is 1;
    if a,b,c,d == a, the output is 1;


module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
