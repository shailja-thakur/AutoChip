module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial value for the output
    initial begin
        out = 0;
    end

    // Toggle flip-flop logic
    always_ff @(posedge clk) begin
        out <= out ^ in; // XOR the input with the current output
    end

endmodule
