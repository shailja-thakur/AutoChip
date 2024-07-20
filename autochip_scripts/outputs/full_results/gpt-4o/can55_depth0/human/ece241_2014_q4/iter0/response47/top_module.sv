module top_module (
    input clk,
    input x,
    output z
    );

    reg q1, q2, q3;
    wire d1, d2, d3;
    wire q1b, q2b, q3b;
    wire xnor_out;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Complementary outputs
    assign q1b = ~q1;
    assign q2b = ~q2;
    assign q3b = ~q3;

    // Gates
    assign d1 = x ^ q1;
    assign d2 = x & q2b;
    assign d3 = x | q3b;

    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
