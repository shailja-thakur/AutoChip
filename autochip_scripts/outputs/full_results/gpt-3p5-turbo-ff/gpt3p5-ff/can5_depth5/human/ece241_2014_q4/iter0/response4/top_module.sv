module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;

    // D flip-flops
    always @(posedge clk)
        d1 <= x ^ q1;
    always @(posedge clk)
        d2 <= ~q2 & x;
    always @(posedge clk)
        d3 <= ~q3 | x;

    // Output z
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
