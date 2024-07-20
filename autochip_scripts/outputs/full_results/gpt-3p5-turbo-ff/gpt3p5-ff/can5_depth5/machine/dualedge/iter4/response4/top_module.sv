module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg prev_clk;

	always @(posedge clk) begin
		if (prev_clk == 0) begin
			qp <= d;
			prev_clk <= 1;
		end
	end
	
	always @(negedge clk) begin
		if (prev_clk == 1) begin
			qn <= d;
			prev_clk <= 0;
		end
	end
	
	always @(posedge clk or negedge clk) begin
		if (prev_clk)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
