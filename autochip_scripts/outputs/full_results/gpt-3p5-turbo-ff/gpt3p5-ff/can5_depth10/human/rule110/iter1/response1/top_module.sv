module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_next; // Next state of q

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q_next[0] <= (q[1] && q[0]) ? 1'b0 : 1'b1;
			q_next[511] <= (q[510] && q[511]) ? 1'b0 : 1'b1;
			for (int i = 1; i < 511; i = i + 1) begin
				q_next[i] <= (q[i-1] && q[i] && q[i+1]) ? 1'b0 : 1'b1;
			end
			q <= q_next;
		end
	end

endmodule
