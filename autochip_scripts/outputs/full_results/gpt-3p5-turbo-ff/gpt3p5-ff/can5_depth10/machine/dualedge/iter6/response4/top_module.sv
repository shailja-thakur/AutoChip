module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	
	always @(posedge clk) begin
		qp <= d;
		qn <= d;
	end
	
	always @(posedge clk) begin
		q <= qp;
	end
	
	always @(negedge clk) begin
		q <= qn;
	end
	
endmodule
