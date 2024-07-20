module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg previous_clk;

	always @(posedge clk) begin
		if (clk != previous_clk)
			qp <= d;
		previous_clk <= clk;
	end
	
	always @(negedge clk) begin
		if (clk != previous_clk)
			qn <= d;
		previous_clk <= clk;
	end
	
	always @(posedge clk) begin
		if (clk)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
