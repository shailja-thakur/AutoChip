module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Registers
	reg [31:0] q_next;

	// Initial value
	parameter INITIAL_VALUE = 32'h1;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= INITIAL_VALUE;
		end else begin
			q <= q_next;
		end
	end

	// Logic to update q_next
	always @(posedge clk) begin
		q_next[31:1] <= q[30:0]; // Shift the value by 1 bit
		q_next[0] <= q[0] ^ q[21] ^ q[1]; // XOR bit 0 with bits 21 and 1
	end
endmodule
