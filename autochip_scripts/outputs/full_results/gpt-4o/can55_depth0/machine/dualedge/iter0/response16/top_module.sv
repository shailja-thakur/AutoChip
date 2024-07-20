module top_module(
	input clk,
	input d,
	output reg q);

	// Internal registers to store the values
	reg qp = 0, qn = 0;

	// Always block for positive edge triggered flip-flop
	always @(posedge clk) begin
		qp <= d;
	end

	// Always block for negative edge triggered flip-flop
	always @(negedge clk) begin
		qn <= d;
	end

	// Assign q based on clk's value
	always @(*) begin
		if (clk)
			q = qp;
		else
			q = qn;
	end

endmodule
