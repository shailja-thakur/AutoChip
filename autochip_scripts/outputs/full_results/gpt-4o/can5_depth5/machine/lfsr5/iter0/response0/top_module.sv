module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;
	
	// State transition logic
	always @(q) begin
		q_next = {q[3:0], q[0]}; // Shift q and wrap around LSB to MSB
		q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
	end
	
	// State register update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1; // Reset value
		end else begin
			q <= q_next;
		end
	end
	
endmodule
