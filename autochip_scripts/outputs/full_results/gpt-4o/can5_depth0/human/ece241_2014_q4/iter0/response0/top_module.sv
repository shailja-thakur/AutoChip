module top_module (
    input clk,
    input x,
    output z
);
    // Internal signals
    reg q1, q2, q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= x ^ q1;       // XOR gate
        q2 <= x & ~q2;      // AND gate
        q3 <= x | ~q3;      // OR gate
    end

    // XNOR the outputs of the flip-flops
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
