module top_module (
	input [2:0] in,
	output [1:0] out
);

    // Sum the number of 1's in the input vector 'in'
    assign out = in[0] + in[1] + in[2];

endmodule
