module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize the output signal
    initial begin
        out = 0;
    end
    
    // Always block that triggers on the positive edge of the clock signal
    always_ff @(posedge clk) begin
        out <= out ^ in;  // Toggle the output signal
    end

endmodule
