module top_module(
	input clk,
	input d,
	output reg q);

	reg qp;
	reg qn;

	always @(posedge clk) begin
		qp <= d;
	end

	always @(negedge clk) begin
		qn <= d;
	end

	always @(posedge clk or negedge clk) begin
		if (clk) begin
			qp <= d;
		end else begin
			qn <= d;
		end
	end

	always @(posedge clk or negedge clk) begin
		if (clk) begin
			q <= qp;
		end else begin
			q <= qn;
		end
	end

	initial begin
		$qmonitor(0, "$time %0d clk=%b, d=%b, q=%b\n", $time, clk, d, q);
	end

endmodule
