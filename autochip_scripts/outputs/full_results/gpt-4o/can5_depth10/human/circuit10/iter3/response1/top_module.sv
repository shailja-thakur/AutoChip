module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= a;  // Capture `a` in the flip-flop on rising edge of clk
    end

    always @(*) begin
        q = state ^ b;  // `q` is XOR of current state and `b`
    end

endmodule
