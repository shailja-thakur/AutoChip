module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp;

	always @(negedge clk or posedge reset) begin
		if (reset)
			q_temp <= 8'b00110100; // set q_temp to 8'b00110100 on reset
		else
			q_temp <= d;
	  end

	always @(posedge clk)
		q <= q_temp;

endmodule
