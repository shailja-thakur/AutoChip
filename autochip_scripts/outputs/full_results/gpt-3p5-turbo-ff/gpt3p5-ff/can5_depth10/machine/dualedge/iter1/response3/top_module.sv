module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	
	initial begin
		qp = 1'b0;
		qn = 1'b0;
	end
	
	always @(posedge clk) begin
		qp <= d;
	end
	
	always @(negedge clk) begin
		qn <= d;
	end
	
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
