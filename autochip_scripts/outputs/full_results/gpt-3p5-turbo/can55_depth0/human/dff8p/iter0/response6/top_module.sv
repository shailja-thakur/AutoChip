module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp; // temporary signal to hold the intermediate value of q

	always @(negedge clk) begin
		if (reset)
			q_temp <= 8'b00110100; // reset to 0x34
		else
			q_temp <= d;
	end
	
	assign q = q_temp;

endmodule
