module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Internal signal to hold the next state for q
	reg [4:0] q_next;
	
	always @(q) begin
		q_next[4:1] = q[3:0];
		q_next[0] = q[4] ^ q[0];
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 5'b1;
		end else begin
			q <= q_next;
		end
	end

endmodule
