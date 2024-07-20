module top_module (
    input clk,
    input x,
    output z
);
    
    wire d1, d2, d3;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // XOR gate and DFF
    assign d1 = x ^ q1;
    dff dff1 (
        .clk(clk),
        .d(d1),
        .q(q1)
    );

    // AND gate and DFF
    assign nq2 = ~q2;
    assign d2 = x & nq2;
    dff dff2 (
        .clk(clk),
        .d(d2),
        .q(q2)
    );

    // OR gate and DFF
    assign nq3 = ~q3;
    assign d3 = x | nq3;
    dff dff3 (
        .clk(clk),
        .d(d3),
        .q(q3)
    );

    // Three-input XNOR gate to produce the output z
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
