module top_module(
	input clk,
	input d,
	output reg q);

	reg qp, qn;

	// Process to update qp with d on positive edge of clk
	always @(posedge clk) begin
		qp <= d;
	end

	// Process to update qn with d on negative edge of clk
	always @(negedge clk) begin
		qn <= d;
	end

	// Assign q the value of qp or qn based on clk signal
	always @(*) begin
		if (clk) begin
			q = qp;
		} else begin
			q = qn;
		end
	end

endmodule
