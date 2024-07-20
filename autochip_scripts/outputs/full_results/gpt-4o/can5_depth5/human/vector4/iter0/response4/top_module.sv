module top_module (
	input [7:0] in,
	output [31:0] out
);

    // Sign-extend the 8-bit 'in' to 32-bit 'out'
    assign out = {{24{in[7]}}, in};

endmodule
