module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Registers for LFSR state
	reg [31:0] state;

	// Reset the output q to 32'h1
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
	end

	// LFSR logic
	always @(posedge clk) begin
		if (reset) begin
			state <= 32'h0;
		end else begin
			// Calculate the next state of the LFSR using XOR gates
			state <= {state[30:0], state[1] ^ state[21] ^ state[31] ^ state[31]};
		end
	end

	// Assign the output q
	assign q = state;

endmodule
