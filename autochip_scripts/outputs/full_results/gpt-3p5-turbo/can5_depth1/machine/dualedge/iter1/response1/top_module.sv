module top_module(
	input clk,
	input d,
	output reg q);

	reg qp, qn;
	reg last_clk;

	always @(posedge clk) begin
		qp <= d;
		last_clk <= 1;
	end

	always @(negedge clk) begin
		qn <= d;
		last_clk <= 0;
	end

	always @(posedge clk or negedge clk) begin
		if (last_clk) begin
			q <= qp;
		end else begin
			q <= qn;
		end
	end

endmodule
