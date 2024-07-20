module top_module (
	input d,
	input ena,
	output logic q
);

	logic q_internal;

	always_comb begin
		if (ena) 
			q_internal = d;
		// If ena is low, q_internal retains its previous value
	end

	assign q = q_internal;

endmodule
