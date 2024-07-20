module top_module (
    input clk,
    input in,
    output logic out
);

    // Flip-flop state register
    logic prev_out;

    always_ff @(posedge clk) begin
        // Update output signal based on the input and previous output
        out <= in ^ prev_out;
        // Update previous output with the current output
        prev_out <= out;
    end

endmodule
