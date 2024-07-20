module top_module (
	input d,
	input ena,
	output logic q
);
    always_comb begin
        // if enable is active, output equals input
        if (ena)
            q = d;
    end
endmodule
