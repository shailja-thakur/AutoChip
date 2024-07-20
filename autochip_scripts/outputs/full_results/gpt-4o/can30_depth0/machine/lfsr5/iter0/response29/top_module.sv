module top_module(
	input clk,
	input reset,
	output reg [4:0] q
);

	reg [4:0] q_next;
	
	// First always block for state transition logic
	always @* begin
		q_next = q[4:1];     // Shift right
		q_next[4] = q[0];    // LSB to MSB
		q_next[2] = q_next[2] ^ q[0]; // XOR with LSB
	end
	
	// Second always block for state update on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1; // Reset value
		end else begin
			q <= q_next; // State transition
		end
	end

endmodule
