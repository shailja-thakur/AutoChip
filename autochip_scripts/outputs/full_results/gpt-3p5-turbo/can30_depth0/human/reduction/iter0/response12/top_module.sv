module top_module (
	input [7:0] in,
	output parity
);

	reg parity;

	always @(*) begin
		parity = ^in;
	end

endmodule
