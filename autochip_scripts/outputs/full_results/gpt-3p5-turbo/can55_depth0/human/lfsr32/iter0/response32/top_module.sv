module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'b1;
		end else begin
			q <= q_next;
		end
	end

	always @(posedge clk) begin
		q_next[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
		q_next[1] <= q[0];
		q_next[2] <= q[1];
		for (int i = 3; i < 32; i=i+1) begin
			q_next[i] <= q[i-1];
		end
	end

endmodule
