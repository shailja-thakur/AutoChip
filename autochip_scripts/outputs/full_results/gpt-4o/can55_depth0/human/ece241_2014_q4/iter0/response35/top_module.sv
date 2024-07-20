module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals
    wire xor_out, and_out, or_out;
    wire q1, q2, q3;
    wire nq1, nq2, nq3;
    
    // D flip-flops with their outputs
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end
    
    // Complementary outputs of the flip-flops
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;
    
    // Logic gates
    assign xor_out = x ^ q1;
    assign and_out = x & nq2;
    assign or_out  = x | nq3;
    
    // XNOR gate output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
