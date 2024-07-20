module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Signals
	wire [7:0] sel_extended;    // Extend sel signal to match the length of in signal
	wire [7:0] sel_duplicated;  // Duplicate sel signal for each bit in the in signal
	
	// Internal wires
	wire [0:255] in_selected;   // Store selected inputs based on the sel signal
	
	// Extend sel signal
	assign sel_extended = {8{sel}};
	
	// Duplicate sel signal
	assign sel_duplicated = sel_extended & (8'b1 << sel);
	
	// Generate in_selected
	assign in_selected = in & sel_duplicated;
	
	// Generate 1-bit output
	assign out = |in_selected;

endmodule
