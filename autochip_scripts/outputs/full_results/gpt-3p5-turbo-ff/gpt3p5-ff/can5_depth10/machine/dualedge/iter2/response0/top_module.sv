module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp;
	reg qn;
	reg [1:0] sync_clk;

	always @(posedge clk) begin
		qp <= d;
		sync_clk <= 2'b01;
	end
	
	always @(negedge clk) begin
		qn <= d;
		sync_clk <= 2'b10;
	end
	
	always @(posedge sync_clk) begin
		if (sync_clk == 2'b01)
			q <= qp;
		else if (sync_clk == 2'b10)
			q <= qn;
	end
	
endmodule
