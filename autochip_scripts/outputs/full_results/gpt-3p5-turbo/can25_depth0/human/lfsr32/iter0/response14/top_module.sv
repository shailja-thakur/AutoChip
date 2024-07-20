module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal wires
	wire feedback;
	wire [31:0] q_next;

	// Feedback calculation
	assign feedback = q[31] ^ q[21] ^ q[1] ^ q[0];

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
	end

	// Next state calculation
	always @(posedge clk) begin
		q_next <= {q[30:0], feedback};
	end

endmodule
