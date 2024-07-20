module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial state of the output
    initial begin
        out = 0;
    end

    // On every positive edge of the clock, toggle the output based on XOR with in
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
