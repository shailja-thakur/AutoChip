module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg prev_clk;

	always @(posedge clk) begin
		qp <= d;
		prev_clk <= 1;
	end
	
	always @(negedge clk) begin
		qn <= d;
		prev_clk <= 0;
	end
	
	always @(posedge clk or negedge clk) begin
		if (prev_clk)
			q <= qp;
		else
			q <= qn;
	end
	
	initial begin
		$monitor("q=%b, clk=%b, d=%b", q, clk, d);
	end
	
endmodule
