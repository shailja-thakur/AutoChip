module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    wire d1, d2, d3;
    wire q1_n, q2_n, q3_n;
    wire xnor_out;

    // D Flip-Flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;

    // XOR, AND, OR gate inputs to D flip-flops
    assign d1 = x ^ q1;
    assign d2 = x & q2_n;
    assign d3 = x | q3_n;

    // XNOR of the flip-flops' outputs
    assign xnor_out = ~(q1 ^ q2 ^ q3);
    assign z = xnor_out;

endmodule
