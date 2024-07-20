module top_module(
	input clk,
	input d,
	output reg q);

	reg qp;
	reg qn;
	reg q_tmp;

	always @(posedge clk) begin
		qp <= d;
	end

	always @(negedge clk) begin
		qn <= d;
	end

	always @(posedge clk or negedge clk) begin
		if (clk) begin
			q_tmp <= qp;
		end else begin
			q_tmp <= qn;
		end
	end

	always @(posedge clk) begin
		q <= q_tmp;
	end

endmodule
