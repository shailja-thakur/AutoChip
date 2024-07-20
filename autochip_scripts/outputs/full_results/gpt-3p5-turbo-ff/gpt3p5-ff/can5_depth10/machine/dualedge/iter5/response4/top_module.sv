module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg sync_clk;

	always @(posedge clk) begin
		qp <= d;
		qn <= d;
		sync_clk <= ~sync_clk;
	end
	
	always @(posedge sync_clk) begin
		if (sync_clk)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
