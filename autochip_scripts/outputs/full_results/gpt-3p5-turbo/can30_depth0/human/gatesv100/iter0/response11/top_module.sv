module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declaration of internal wires/registers
	reg [98:0] temp_out_both;
	reg [99:1] temp_out_any;
	reg [99:0] temp_out_different;
	
	// Logic to compute 'out_both'
	always @* begin
		temp_out_both = in[98:0] & in[99:1];
	end
	
	// Logic to compute 'out_any'
	always @* begin
		temp_out_any[99] = in[98] | in[99];
		temp_out_any[98:1] = in[97:0] | in[98:1];
	end
	
	// Logic to compute 'out_different'
	always @* begin
		temp_out_different[99] = (in[99] != in[0]);
		temp_out_different[98:0] = (in[98:0] != in[99:1]);
	end
	
	// Assign internal wires/registers to module outputs
	assign out_both = temp_out_both;
	assign out_any = temp_out_any;
	assign out_different = temp_out_different;
	
endmodule
