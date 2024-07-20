module top_module (
	input [7:0] in,
	output [31:0] out
);

wire [23:0] replicated_sign_bit;
assign replicated_sign_bit = {24 {in[7]}};

assign out = {replicated_sign_bit, in};

endmodule
