module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire reset,
	output reg [7:0] q);

	reg [7:0] q_temp;
	
	always @(negedge clk or posedge reset) begin
		if(reset)
			q_temp <= 8'h34;
		else
			q_temp <= d;
	end
	
	always @(posedge clk) begin
		q <= q_temp;
	end
	
endmodule
