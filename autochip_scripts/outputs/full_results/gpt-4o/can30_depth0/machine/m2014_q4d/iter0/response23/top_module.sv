module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial value of output
    initial begin
        out = 0;
    end

    // Always block triggered on the rising edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in;  // Toggle output using XOR with input
    end

endmodule
