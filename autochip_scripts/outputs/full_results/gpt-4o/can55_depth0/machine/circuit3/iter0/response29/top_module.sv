module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

    wire or_ab; // Intermediate wire for OR of a and b
    wire or_cd; // Intermediate wire for OR of c and d

    assign or_ab = a | b;
    assign or_cd = c | d;

    assign q = or_ab & or_cd;

endmodule
