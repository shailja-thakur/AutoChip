module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;
    wire q1_bar, q2_bar, q3_bar;
    wire xor_out, and_out, or_out;
    
    // Flip-flops
    always @(posedge clk) begin
        d1 <= x ^ q1;
        d2 <= x & ~q2;
        d3 <= x | ~q3;
    end
    
    assign q1 = d1;
    assign q2 = d2;
    assign q3 = d3;
    
    // Complementary outputs
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;
    
    // Three-input XNOR gate
    assign xor_out = q1;
    assign and_out = q2;
    assign or_out = q3;
    
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
