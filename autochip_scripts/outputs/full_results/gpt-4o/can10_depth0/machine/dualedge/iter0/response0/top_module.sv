module top_module(
	input clk,
	input d,
	output reg q);
	
	reg qp, qn;

	// Synchronize with positive edge of clock
	always @(posedge clk) begin
		qp <= d;
	end

	// Synchronize with negative edge of clock
	always @(negedge clk) begin
		qn <= d;
	end

	// Output logic based on the clock signal
	always @(clk or qp or qn) begin
		if (clk) begin
			q = qp;
		end else begin
			q = qn;
		end
	end

endmodule
