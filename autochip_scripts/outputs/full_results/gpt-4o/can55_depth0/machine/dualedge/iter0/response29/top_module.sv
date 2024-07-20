module top_module(
	input clk,
	input d,
	output reg q);

	// Intermediate registers for synchronization
	reg qp;
	reg qn;

	// Always block for positive edge of the clock
	always @(posedge clk) begin
		qp <= d;
	end

	// Always block for negative edge of the clock
	always @(negedge clk) begin
		qn <= d;
	end

	// Assign output q based on clock signal
	always @(*) begin
		if (clk)
			q = qp;
		else
			q = qn;
	end

endmodule
