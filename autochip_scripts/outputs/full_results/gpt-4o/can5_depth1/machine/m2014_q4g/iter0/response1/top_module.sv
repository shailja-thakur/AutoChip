module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	always_comb begin
		out = ~ (in1 ^ in2) ^ in3;
	end
endmodule
