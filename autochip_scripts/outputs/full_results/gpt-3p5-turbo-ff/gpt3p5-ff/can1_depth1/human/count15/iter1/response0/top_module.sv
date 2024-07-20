module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	reg [3:0] q_next;

	always @(posedge clk or posedge reset) begin
		if(reset)
			q_next <= 4'b0;
		else
			q_next <= (q == 4'b1111) ? 4'b0 : q + 4'b1;
	end
	
	always @(posedge clk) begin
		if (reset)
			q <= q_next;
	end

endmodule
