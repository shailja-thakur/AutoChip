module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize output signal to 0
    initial out = 0;
    
    // Always block to handle the clock edge and toggle logic
    always_ff @(posedge clk) begin
        out <= out ^ in;  // XOR the input with the current output to toggle 
    end
    
endmodule
