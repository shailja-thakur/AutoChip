module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Intermediate register to hold the next state
	reg [31:0] q_next;

	// Sequential logic to update the shift register
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;    // Reset the register to the initial value
		else
			q <= q_next;   // Update register with the next state
	end

	// Combinational logic to compute the next state
	always @(*) begin
		q_next = {q[30:0], q[31]}; // Shift left by 1 bit
		q_next[31] = q[0] ^ q[21] ^ q[1]; // XOR bits 21 and 1 with new bit 31
	end

endmodule
