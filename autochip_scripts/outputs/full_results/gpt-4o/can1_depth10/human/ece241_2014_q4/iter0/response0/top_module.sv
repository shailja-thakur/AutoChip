module top_module (
    input clk,
    input x,
    output z
);

    reg dff_q1, dff_q2, dff_q3;

    wire xor_out, and_out, or_out;
    wire dff_q1_comp, dff_q2_comp, dff_q3_comp;

    // Complementary outputs of the flip-flops
    assign dff_q1_comp = ~dff_q1;
    assign dff_q2_comp = ~dff_q2;
    assign dff_q3_comp = ~dff_q3;

    // Gates
    assign xor_out = x ^ dff_q1;
    assign and_out = x & dff_q2_comp;
    assign or_out = x | dff_q3_comp;
    
    // D Flip-flops
    always @(posedge clk) begin
        dff_q1 <= xor_out;
        dff_q2 <= and_out;
        dff_q3 <= or_out;
    end

    // XNOR of the outputs of the flip-flops
    assign z = ~(dff_q1 ^ dff_q2 ^ dff_q3);

endmodule
