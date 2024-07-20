module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	
	always @(posedge clk) begin
		qp <= d;
		q <= qp;
	end
	
	always @(negedge clk) begin
		qn <= d;
		q <= qn;
	end
	
endmodule
