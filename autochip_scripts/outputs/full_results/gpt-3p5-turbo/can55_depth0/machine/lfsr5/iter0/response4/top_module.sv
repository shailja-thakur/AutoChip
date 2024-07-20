module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Declare q_next as reg type to store the next state
	reg [4:0] q_next;

	// State transition always block triggered when q changes
	always @(q) begin
		// Assign q_next with q[4:1]
		q_next[4:1] = q[3:0];
		// Assign q_next[4] with q[0]
		q_next[4] = q[0];
		// XOR q_next[2] with q[0]
		q_next[2] = q_next[2] ^ q[0];
	end

	// Sequential always block triggered at positive edge of clk
	always @(posedge clk) begin
		// Check if reset is active
		if (reset) begin
			// Assign reset value 5'h1 to q
			q <= 5'h1;
		end else begin
			// Assign next state q_next to q
			q <= q_next;
		end
	end

endmodule
