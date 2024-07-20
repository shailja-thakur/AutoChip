module top_module(
	input clk,
	input reset,
	output reg [31:0] q
);

	// Internal registers
	reg [31:0] q_next;

	// Initial value of the register
	reg [31:0] initial_value = 32'h1;
	
	// Assign the initial value to the register
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= initial_value;
		end else begin
			q <= q_next;
		end
	end
	
	// Update the next value of the register
	always @(posedge clk) begin
		q_next[31:1] <= q[30:0];
		q_next[21] <= q[0] ^ q[1];
		q_next[1] <= q[0] ^ q[0];
		q_next[0] <= q[0];
	end

endmodule
