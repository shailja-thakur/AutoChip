module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q_next <= 1;
		else
			q_next <= {q[3] ^ q[1], q[4:1]};
	end
	
	always @(posedge clk) begin
		q <= q_next;
	end

endmodule
