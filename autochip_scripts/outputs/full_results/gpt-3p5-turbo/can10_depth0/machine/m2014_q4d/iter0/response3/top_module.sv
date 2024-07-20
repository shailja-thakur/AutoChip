module top_module (
    input clk,
    input in,
    output logic out
);

    // Registers to store previous values
    reg prev_out;
    
    always_ff @(posedge clk)
    begin
        // Toggle the output signal
        out <= in ^ prev_out;
        // Store the current output signal as previous
        prev_out <= out;
    end
    
endmodule
