module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal registers
	reg [31:0] q_next;

	// Initial value for register
	initial begin
		q = 32'h1;
		q_next = q;
	end

	// Clock edge detection
	always @(posedge clk)
		begin
			if (reset)
				q <= 32'h1;
			else
				q <= q_next;
			
			q_next[0] <= q[31];
			q_next[31:1] <= q[30:0] ^ q[0];
		end
endmodule
