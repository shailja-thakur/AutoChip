module top_module (
	input clk,
	input in,
	output logic out
);

	logic d;
	reg logic q;

	assign d = in ^ q;

	always_ff @(posedge clk) begin
		q <= d;
	end

	assign out = q;

endmodule
