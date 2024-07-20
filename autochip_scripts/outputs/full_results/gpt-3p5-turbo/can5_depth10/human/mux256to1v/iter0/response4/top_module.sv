module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Create a 4-bit wire for each 256-to-1 multiplexer input
	wire [3:0] in_sel0 = in[3:0];
	wire [3:0] in_sel1 = in[7:4];
	wire [3:0] in_sel2 = in[11:8];
	// Declare additional wires for other selector inputs
	
	assign out = (sel == 0) ? in_sel0 :
				(sel == 1) ? in_sel1 :
				(sel == 2) ? in_sel2 :
				// Add additional cases for other selector inputs
				4'b0; // Default output value when sel is out of range
					
endmodule
