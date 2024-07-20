module top_module (
	input [7:0] in,
	output [31:0] out
);
    // Sign-extend the 8-bit number to 32 bits
    assign out = {{24{in[7]}}, in};
endmodule
