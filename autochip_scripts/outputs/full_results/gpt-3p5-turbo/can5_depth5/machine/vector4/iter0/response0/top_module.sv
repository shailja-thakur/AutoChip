module top_module (
	input [7:0] in,
	output [31:0] out
);
	assign out = {in, {24{in}}};  // replicates the 8-bit input 24 times and concatenates it with the original 8-bit input
endmodule
