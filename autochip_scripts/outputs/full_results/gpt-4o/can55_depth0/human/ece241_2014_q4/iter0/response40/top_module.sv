module top_module (
    input clk,
    input x,
    output z
);
    wire d1, d2, d3;
    reg q1, q2, q3;

    // Gates connected to the flip-flop inputs
    assign d1 = x ^ q1;               // XOR gate
    assign d2 = x & ~q2;              // AND gate
    assign d3 = x | ~q3;              // OR gate

    // D Flip-Flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
