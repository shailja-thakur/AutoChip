module top_module (
    input clk,
    input x,
    output z
);
    reg dff1_q, dff2_q, dff3_q;

    // Flip-flops
    always @(posedge clk) begin
        dff1_q <= dff1_d;
        dff2_q <= dff2_d;
        dff3_q <= dff3_d;
    end

    // Logic for the D flip-flops
    wire dff1_d = x ^ dff1_q;
    wire dff2_d = x & ~dff2_q;
    wire dff3_d = x | ~dff3_q;

    // XNOR of the outputs of the D flip-flops
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
