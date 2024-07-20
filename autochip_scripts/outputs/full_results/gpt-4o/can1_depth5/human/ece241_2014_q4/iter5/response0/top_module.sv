module top_module (
    input clk,
    input x,
    output reg z
);
    reg dff1_q, dff2_q, dff3_q;

    wire xor_out, and_out, or_out;
    
    assign xor_out = x ^ dff1_q;
    assign and_out = x & ~dff2_q;
    assign or_out = x | ~dff3_q;

    // Flip-flops
    always @(posedge clk) begin
        dff1_q <= xor_out;  
        dff2_q <= and_out;  
        dff3_q <= or_out;  
    end

    // XNOR of the outputs of the D flip-flops
    always @(posedge clk) begin
        z <= ~(dff1_q ^ dff2_q ^ dff3_q);
    end

endmodule
