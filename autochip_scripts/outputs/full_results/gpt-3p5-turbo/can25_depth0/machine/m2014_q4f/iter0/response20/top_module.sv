module top_module (
	input in1,
	input in2,
	output logic out
);

    // The output signal is the logical AND of in1 and the logical NOT of in2.
    always_comb begin
        out = in1 & ~in2;
    end

endmodule
