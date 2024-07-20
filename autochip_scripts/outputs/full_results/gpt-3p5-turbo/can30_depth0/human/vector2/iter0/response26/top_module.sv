module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	wire [7:0] first_byte;
	wire [7:0] second_byte;
	wire [7:0] third_byte;
	wire [7:0] fourth_byte;
	
	assign first_byte = in[7:0];
	assign second_byte = in[15:8];
	assign third_byte = in[23:16];
	assign fourth_byte = in[31:24];
	
	assign out = {fourth_byte, third_byte, second_byte, first_byte};

endmodule
