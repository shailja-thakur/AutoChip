module top_module (
    input clk,
    input x,
    output z
);

    // Intermediate signals for the outputs of the D flip-flops
    reg dff1_q, dff2_q, dff3_q;
    
    // XOR, AND, OR gate outputs
    wire xor_out, and_out, or_out;

    // Initialize D flip-flops to 0
    initial begin
        dff1_q = 1'b0;
        dff2_q = 1'b0;
        dff3_q = 1'b0;
    end
    
    // XOR, AND, OR gates
    assign xor_out = x ^ dff1_q;
    assign and_out = x & ~dff2_q;
    assign or_out  = x | ~dff3_q;

    // D flip-flops
    always @(posedge clk) begin
        dff1_q <= xor_out;
        dff2_q <= and_out;
        dff3_q <= or_out;
    end

    // Three-input XNOR gate
    assign z = ~(dff1_q ^ dff2_q ^ dff3_q);

endmodule
