module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	reg [98:0] out_both_reg;
	reg [99:1] out_any_reg;
	reg [99:0] out_different_reg;
	
	// Logic for out_both
	always @(*) begin
		out_both_reg = in[98:0] & in[99:1];
	end
	assign out_both = out_both_reg;
	
	// Logic for out_any
	always @(*) begin
		out_any_reg[99:1] = in[98:0] | in[99:1];
	end
	assign out_any = out_any_reg;
	
	// Logic for out_different
	always @(*) begin
		out_different_reg[99] = (in[99] != in[0]);
		out_different_reg[98:0] = (in[98:0] != in[99:1]);
	end
	assign out_different = out_different_reg;
	
endmodule
