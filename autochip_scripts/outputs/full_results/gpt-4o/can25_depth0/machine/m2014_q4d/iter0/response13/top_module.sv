module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial value for output
    initial begin
        out = 0;
    end

    // Always block sensitive to the positive edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
