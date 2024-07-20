module top_module (
	input [7:0] in,
	output [31:0] out
);

    // Replicate the most significant bit (sign bit) of 'in' 24 times and concatenate with 'in'
    assign out = {{24{in[7]}}, in};

endmodule
