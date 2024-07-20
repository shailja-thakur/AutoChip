module top_module(
	input clk,
	input d,
	output reg q);

	// Registers for positive and negative clock edges
	reg qp;
	reg qn;

	// Always block for positive clock edge
	always @(posedge clk)
	begin
		qp <= d;
	end

	// Always block for negative clock edge
	always @(negedge clk)
	begin
		qn <= d;
	end

	// Assign output q based on clock edge
	always @(posedge clk or negedge clk)
	begin
		if (clk)
			q <= qp;
		else
			q <= qn;
	end

endmodule
