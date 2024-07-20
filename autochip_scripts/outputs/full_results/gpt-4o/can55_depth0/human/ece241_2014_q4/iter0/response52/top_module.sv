module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire d1, d2, d3;

    // XOR gate with flip-flop output
    assign d1 = x ^ q1;

    // AND gate with complemented flip-flop output
    assign d2 = x & ~q2;

    // OR gate with complemented flip-flop output
    assign d3 = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
