module top_module (
    input clk,
    input in,
    output logic out
);

    // Initial state of the output signal
    initial begin
        out = 0;
    end

    // Toggle flip-flop logic on the rising edge of the clock
    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
