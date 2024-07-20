module top_module (
    input clk,
    input in,
    output logic out
);

    // Declare a flip-flop variable to store the previous output state
    logic prev_out;

    always_ff @(posedge clk) begin
        // XOR the input with the previous output to get the new output
        out <= in ^ prev_out;
        // Store the current output in the flip-flop variable
        prev_out <= out;
    end

endmodule
