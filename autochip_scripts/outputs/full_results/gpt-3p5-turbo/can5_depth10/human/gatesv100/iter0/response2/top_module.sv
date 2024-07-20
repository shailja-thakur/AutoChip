module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Variable declarations
	reg [98:0] both_temp;
	reg [99:0] any_temp;
	reg [99:0] different_temp;
	
	// Logic for out_both
	always @* begin
		both_temp = in[98:0] & in[99:1];
	end
	
	// Assigning output for out_both
	assign out_both = both_temp;
	
	// Logic for out_any
	always @* begin
		any_temp = {in[98], in[99:1]};
	end
	
	// Assigning output for out_any
	assign out_any = any_temp;
	
	// Logic for out_different
	always @* begin
		different_temp = in ^ {in[99], in[99:1]};
	end
	
	// Assigning output for out_different
	assign out_different = different_temp;

endmodule
