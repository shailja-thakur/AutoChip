module top_module (
  input in1,
  input in2,
  output logic out
);
	always_comb
	begin
		if (in1 && !in2)
			out = 1;
		else
			out = 0;
	end
endmodule
