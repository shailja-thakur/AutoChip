module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

    // Declare internal signal for the flip flop
    logic q_int;
    
    // Sequential logic process triggered by positive edge of the clock
    always_ff @(posedge clk) begin
        if (r) begin
            q_int <= 0; // Active high synchronous reset
        end else begin
            q_int <= d;
        end
    end
    
    // Assign the output
    assign q = q_int;

endmodule
