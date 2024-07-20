module top_module (
	input [3:0] in,
	output reg [2:0] out_both,
	output reg [3:1] out_any,
	output reg [3:0] out_different
);

	// Bitwise AND operation
	assign out_both = in[2:0] & in[3:1];
	
	// Bitwise OR operation
	assign out_any = in[2:0] | in[3:1];
	
	// Bitwise XOR operation
	always @* begin
		out_different[3] = in[3] ^ in[2];
		out_different[2] = in[2] ^ in[1];
		out_different[1] = in[1] ^ in[0];
		out_different[0] = in[3] ^ in[1];
	end

endmodule
