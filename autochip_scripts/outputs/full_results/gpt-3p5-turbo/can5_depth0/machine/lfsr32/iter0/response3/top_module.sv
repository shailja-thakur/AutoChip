module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] q_next;

	// Always block for q_next update
	always @(posedge clk) begin
		// Reset to initial value if reset is high
		if (reset) begin
			q <= 32'h1;
		end
		// Update q with q_next value
		else begin
			q <= q_next;
		end
	end

	// Assign q_next based on q value
	always @(q) begin
		q_next[31:1] = q[30:0];
		q_next[21] = q[0] ^ q[21];
		q_next[1] = q[0] ^ q[1];
		q_next[0] = q[0];
	end

endmodule
