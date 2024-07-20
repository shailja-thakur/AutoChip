module top_module (
	input d,
	input ena,
	output logic q
);
    
    always_comb begin
        if (ena == 1'b1) // Check if the enable signal is active
            q = d;      // Assign the input to the output
        else
            q = q;      // Keep the output unchanged
    end

endmodule
