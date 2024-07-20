module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

reg [15:0] q_next;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		q <= 0;
		ena <= 0;
	end else begin
		q <= q_next;
	end
end

always @(posedge clk) begin
	if(reset) begin
		q_next <= 0;
	end else begin
		q_next <= q + 1;
		ena <= ena + 1;
	end
end

endmodule
