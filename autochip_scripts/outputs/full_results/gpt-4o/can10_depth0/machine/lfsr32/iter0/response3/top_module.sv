module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal register to store the next value
	reg [31:0] q_next;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;  // Reset the register to the initial value, 32'h1
		else
			q <= q_next;  // Update the register with the next value
	end
	
	always @(*) begin
		// Shift q and wrap the bit shifted out to bit 31
		q_next[31] = q[0];
		q_next[30:1] = q[31:2];
		q_next[0] = q[21] ^ q[1] ^ q[0];
	end
endmodule
