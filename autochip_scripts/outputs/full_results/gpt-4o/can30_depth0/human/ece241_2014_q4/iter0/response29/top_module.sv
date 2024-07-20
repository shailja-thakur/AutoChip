module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;

    // XOR gate with the flip-flop's output
    assign d1 = x ^ q1;
    // AND gate with the flip-flop's complemented output
    assign d2 = x & ~q2;
    // OR gate with the flip-flop's complemented output
    assign d3 = x | ~q3;

    // D flip-flops with clock
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
