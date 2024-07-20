module top_module(
	input clk,
	input d,
	output reg q);

	// Create two flip-flops triggered on opposite edges of the clock
	reg q1, q2;

	always @(posedge clk) begin
		q1 <= d;
	end
	
	always @(negedge clk) begin
		q2 <= q1;
	end
	
	assign q = q2;
	
endmodule
