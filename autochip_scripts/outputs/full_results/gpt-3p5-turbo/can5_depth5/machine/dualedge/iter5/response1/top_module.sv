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

	always @(posedge clk) begin
		q <= qp;
		if (!clk) begin
			q <= qn;
		end
	end

	initial begin
		$monitor("q = %b", q);
	end

endmodule
