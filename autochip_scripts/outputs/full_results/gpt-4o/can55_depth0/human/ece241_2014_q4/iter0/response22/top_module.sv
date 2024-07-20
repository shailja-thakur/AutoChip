module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;  // D flip-flop outputs

    wire d1, d2, d3;  // D inputs for flip-flops
    wire q1_bar, q2_bar, q3_bar; // Complementary outputs of flip-flops
    wire x_xnor_out;  // Output of the three-input XNOR

    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;

    assign d1 = x ^ q1;
    assign d2 = x & q2_bar;
    assign d3 = x | q3_bar;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    assign z = ~(q1 ^ q2 ^ q3); // Three-input XNOR gate

endmodule
