module top_module (
	input d,
	input ena,
	output logic q
);

always_comb begin
    if (ena)
        q = d;
    // If ena is low, keep q unchanged
end

endmodule
