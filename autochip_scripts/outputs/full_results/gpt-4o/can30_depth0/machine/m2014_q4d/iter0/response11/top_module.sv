module top_module (
    input clk,
    input in,
    output logic out
);
    // Initial value for output signal
    initial begin
        out = 0;
    end
    
    // Always block to handle the functionality on the positive edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in; // XOR operation to toggle the output
    end
endmodule
