module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    reg d1, d2, d3;

    // Combinational logic for D flip-flop inputs
    always @(*) begin
        d1 = x ^ q1;         // XOR
        d2 = x & ~q2;        // AND
        d3 = x | ~q3;        // OR
    end

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
