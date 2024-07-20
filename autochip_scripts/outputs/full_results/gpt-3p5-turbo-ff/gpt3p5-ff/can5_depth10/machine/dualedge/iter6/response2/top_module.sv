module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg sync_clk;

	always @(posedge clk) begin
	    if (sync_clk == 0)
		    qp <= d;
	end
	
	always @(negedge clk) begin
	    if (sync_clk == 1)
		    qn <= d;
	end
	
	always @(posedge sync_clk) begin
		if (sync_clk == 1)
			q <= qp;
		else
			q <= qn;
	end
	
endmodule
