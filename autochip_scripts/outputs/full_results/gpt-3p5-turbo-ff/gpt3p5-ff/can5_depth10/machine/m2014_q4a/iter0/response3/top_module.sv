module top_module (
	input d,
	input ena,
	output logic q
);

// Combinational logic circuit
always_comb begin
	if (ena)
		q = d;
end

endmodule
