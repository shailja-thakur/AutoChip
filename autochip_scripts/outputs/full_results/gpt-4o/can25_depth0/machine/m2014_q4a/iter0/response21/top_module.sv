module top_module (
	input d,
	input ena,
	output logic q
);

always_comb begin
	if (ena) q = d;
	else q = q;  // Maintain the current value when ena is low
end

endmodule
