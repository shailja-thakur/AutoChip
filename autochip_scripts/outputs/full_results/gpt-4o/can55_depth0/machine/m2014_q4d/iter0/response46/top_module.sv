module top_module (
    input clk,
    input in,
    output logic out
);

    // Initialize the output signal
    initial out = 0;

    // Always block that triggers on the positive edge of the clock signal
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
