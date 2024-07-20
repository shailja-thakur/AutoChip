module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;

		q_next <= {q[30:1], q[31] ^ q[21] ^ q[1] ^ q[0]};

		// Shifting bit 0 to bit 31
		q_next[31] <= q[0];
	end
	
endmodule
