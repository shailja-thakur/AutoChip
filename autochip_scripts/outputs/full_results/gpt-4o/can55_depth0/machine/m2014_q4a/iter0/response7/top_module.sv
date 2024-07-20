module top_module (
	input d,
	input ena,
	output logic q
);

logic q_internal;

// always block to control the output based on enable
always_comb begin
	if (ena)
		q_internal = d;
end

// assign q to q_internal
assign q = q_internal;

endmodule
