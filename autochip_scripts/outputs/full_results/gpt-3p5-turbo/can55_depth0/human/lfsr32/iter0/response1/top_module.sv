module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] state;
	reg feedback;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 32'h1;
		end else begin
			state <= {state[30:0], feedback};
		end
	end

	// Feedback logic
	always @(state) begin
		feedback = state[31] ^ state[21] ^ state[1] ^ state[0];
	end

	// Output assignment
	assign q = state;

endmodule
