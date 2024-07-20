module top_module(
    input clk,
    input d,
    output reg q
);

	reg qp;
	reg qn;

	always @(posedge clk) begin
		qp <= d;
		q <= qp; // Assign q as soon as qp is updated
	end

	always @(negedge clk) begin
		qn <= d;
		q <= qn; // Assign q as soon as qn is updated
	end

endmodule
