module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp;
	reg [7:0] q_reset;

	always @(negedge clk)
	begin
		if (reset)
			q_temp <= 8'd34;
		else
			q_temp <= d;
	end
	
	always @(posedge clk)
	begin
		if (reset)
			q_reset <= 8'd34;
		else
			q_reset <= q_temp;
	end
	
	assign q = q_reset;

endmodule
