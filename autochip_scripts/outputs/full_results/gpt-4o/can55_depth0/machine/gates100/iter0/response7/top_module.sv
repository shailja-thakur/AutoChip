module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	integer i;
	reg and_result;
	reg or_result;
	reg xor_result;

	always @(*) begin
		and_result = 1;
		or_result = 0;
		xor_result = 0;

		for (i = 0; i < 100; i = i + 1) begin
			and_result = and_result & in[i];
			or_result = or_result | in[i];
			xor_result = xor_result ^ in[i];
		end
	end

	assign out_and = and_result;
	assign out_or = or_result;
	assign out_xor = xor_result;

endmodule
