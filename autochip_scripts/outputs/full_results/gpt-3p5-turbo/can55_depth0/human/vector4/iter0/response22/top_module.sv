module top_module (
	input [7:0] in,
	output [31:0] out
);

reg [31:0] extended_num;

assign extended_num = {24{in[7]}, in};

assign out = extended_num;

endmodule
