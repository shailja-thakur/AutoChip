module top_module (
	input clk,
	input in,
	output logic out
);
    // Internal register to hold the output value
    logic q;
    
    // Initial condition
    initial begin
        q = 1'b0;
    end
    
    // Always block triggered on the positive edge of the clock
    always_ff @(posedge clk) begin
        q <= q ^ in; // XOR the current value of q with the input in
    end
    
    // Assign the output to the internal register value
    assign out = q;

endmodule
