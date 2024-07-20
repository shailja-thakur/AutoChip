module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Register array for the LFSR
	reg [31:0] register;

	// Tap positions for XOR operation
	reg tap32, tap22, tap2, tap1;

	// Next state of the register
	reg [31:0] next_state;

	// Output bit for the LFSR
	assign q = register[0];

	// Assign taps
	assign tap32 = register[31];
	assign tap22 = register[21];
	assign tap2 = register[1];
	assign tap1 = register[0];

	// Reset logic
	always @(posedge clk) begin
		if (reset) begin
			register <= 32'h1;
		end else begin
			next_state[31:1] = register[30:0];
			next_state[0] = tap32 ^ tap22 ^ tap2 ^ tap1;
			register <= next_state;
		end
	end
endmodule
