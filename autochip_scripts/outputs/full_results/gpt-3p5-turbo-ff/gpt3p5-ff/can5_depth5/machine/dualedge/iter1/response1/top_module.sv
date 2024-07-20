module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	
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
	
	initial begin
	    clk = 0;
	    forever #5 clk = ~clk;
	end
	
endmodule
