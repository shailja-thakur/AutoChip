module top_module(
	input clk,
	input d,
	output q);
	
	reg q_internal;

	always @(posedge clk) begin
		q_internal <= d;
	end
	
	always @(negedge clk) begin
		q <= q_internal;
	end

endmodule
