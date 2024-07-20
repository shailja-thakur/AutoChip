module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal wires for LFSR
	wire [31:0] next_state;
	wire [3:0] taps;

	// Assign tap positions
	assign taps = 4'b1011;

	// Register for the LFSR state
	always @(posedge clk or posedge reset) begin: lfsr
		if (reset) begin
			q <= 32'h1; // Reset output q to 32'h1
		end else begin
			q <= next_state;
		end
	end

	// Feedback XOR gates
	assign next_state[31] = q[21] ^ q[1] ^ q[0];
	assign next_state[30:0] = q[31:1];
endmodule
