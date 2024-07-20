module top_module (
    input clk,
    input in,
    output logic out
);
    // Initialize the output signal to 0
    initial begin
        out = 0;
    end

    // Toggling the output signal on the rising edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
