module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	reg [98:0] out_both_reg; // Register for out_both
	reg [99:1] out_any_reg; // Register for out_any
	reg [99:0] out_different_reg; // Register for out_different

	always @(*) begin
		for (int i = 0; i < 99; i = i + 1) begin
			out_both_reg[i] = in[i] & in[i+1];
			out_any_reg[i+1] = in[i] | in[i+1];
			out_different_reg[i] = in[i] ^ in[i+1];
		end
		out_both_reg[99] = in[99] & in[0];
		out_any_reg[0] = in[0];
		out_different_reg[99] = in[99] ^ in[0];	
	end

	assign out_both = out_both_reg;
	assign out_any = out_any_reg;
	assign out_different = out_different_reg;

endmodule
