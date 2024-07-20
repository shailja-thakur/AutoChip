module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
    
    // Define a register to store the data
    reg logic q_reg;
    
    // Assign the output of the register to the output signal q
    assign q = q_reg;
    
    // Synchronize the register with the clock
    always_ff @(posedge clk) begin
        if (r) begin
            // Reset the register to 0
            q_reg <= 0;
        end else begin
            // Store the data input in the register
            q_reg <= d;
        end
    end
endmodule
