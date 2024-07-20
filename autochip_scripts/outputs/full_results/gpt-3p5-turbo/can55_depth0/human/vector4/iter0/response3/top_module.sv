module top_module (
	input [7:0] in,
	output [31:0] out
);

// Sign extension by replicating the sign bit
assign out = {24{in[7]}, in};

endmodule
