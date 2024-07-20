module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Define internal signals
	reg [31:0] d;
	reg [31:0] next_q;

	// Define Galois LFSR taps
	parameter [31:0] taps = 32'b1_0000_0000_0000_0000_0100_0000_0000_0000;

	// Reset logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1; // Reset q to 32'h1
		else
			q <= next_q; // Update q with next value
	end

	// LFSR logic
	always @(posedge clk) begin
		// Generate next value
		d <= q ^ (q & taps);

		// Shift values
		next_q <= {d[30:0], q[31]}; // Shift left, move MSB to LSB
	end

endmodule
