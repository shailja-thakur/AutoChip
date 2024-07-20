module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
    
	reg [31:0] q_next; // Next state of q
    
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1; // Reset q to 32'h1 when reset is active high
		end else begin
			// Calculating next state using taps at bit positions 32, 22, 2, and 1
			q_next[31] <= q[31] ^ q[22] ^ q[2] ^ q[1];
			q_next[30:0] <= q[31:1]; // Shifting all other bits

			q <= q_next; // Updating q with the next state
		end
	end
endmodule
