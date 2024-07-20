module top_module(
	input clk,
	input d,
	output reg q
	);
	
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
	
endmodule
