module top_module (
	input in1,
	input in2,
	output logic out
);
	always @(*) begin
		out = in1 && ~in2;
	end
endmodule
