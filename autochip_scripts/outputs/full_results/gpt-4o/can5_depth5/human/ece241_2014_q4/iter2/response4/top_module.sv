module top_module (
    input clk,
    input x,
    output z
);
    reg d1, d2, d3;
    reg q1, q2, q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Inputs to the D flip-flops
    always @(*) begin
        d1 = x ^ q1;
        d2 = x & ~q2;
        d3 = x | ~q3;
    end

    // XNOR gate with inputs q1, q2, q3
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
