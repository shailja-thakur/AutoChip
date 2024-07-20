module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg sync_clk;

	always @(posedge clk) begin
		qp <= d;
		sync_clk <= 1;
	end
	
	always @(negedge clk) begin
		qn <= d;
		sync_clk <= 0;
	end
	
	always @(posedge sync_clk) begin
		if (sync_clk)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
