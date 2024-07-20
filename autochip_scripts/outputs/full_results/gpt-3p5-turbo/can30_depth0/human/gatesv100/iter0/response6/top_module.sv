module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

	// Register variables for intermediate calculations
	reg [98:0] both_reg;
	reg [99:1] any_reg;
	reg [99:0] different_reg;
	
	always @(in) begin
		// Calculate out_both
		both_reg[98:0] <= in[98:0] & in[99:1];
		
		// Calculate out_any
		any_reg[99:1] <= in[99:1] | in[98:0];
		
		// Calculate out_different
		different_reg[98:0] <= in[98:0] ^ in[99:1];
		different_reg[99] <= in[99] ^ in[0];
	end
	
	assign out_both = both_reg;
	assign out_any = any_reg;
	assign out_different = different_reg;
	
endmodule
