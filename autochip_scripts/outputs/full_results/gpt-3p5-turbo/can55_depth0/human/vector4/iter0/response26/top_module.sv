module top_module (
	input [7:0] in,
	output [31:0] out
);

// Sign extend the input to 32 bits by replicating the sign bit 24 times
wire [31:0] sign_extended;
assign sign_extended = {24{in[7]}, in};

// Assign the sign-extended value to the output
assign out = sign_extended;

endmodule
