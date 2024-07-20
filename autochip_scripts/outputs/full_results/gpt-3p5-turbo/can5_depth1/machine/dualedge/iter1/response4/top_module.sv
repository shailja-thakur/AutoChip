module top_module(
	input clk,
	input d,
	output reg q);

	reg qp, qn;

	always @(posedge clk) begin
		qp <= d;
	end

	always @(negedge clk) begin
		qn <= d;
	end

	always @(posedge clk) begin
		if (clk) begin
			q <= qp;
		end else begin
			q <= qn;
		end
	end

	initial begin
		q <= 0; // Initialize the 'q' register with a default value
	end

endmodule
