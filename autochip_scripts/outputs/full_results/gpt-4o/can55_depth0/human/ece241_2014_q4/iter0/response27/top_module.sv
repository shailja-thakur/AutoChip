module top_module (
    input clk,
    input x,
    output z
);
    // D flip-flop outputs
    reg q1, q2, q3;
    
    // Complementary outputs of D flip-flops
    wire nq1, nq2, nq3;
    
    // Combinational logic
    wire xor_out, and_out, or_out;
    
    // Complement flip-flop outputs
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;
    
    // The gates
    assign xor_out = x ^ q1;
    assign and_out = x & nq2;
    assign or_out = x | nq3;
    
    // Flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end
    
    // XNOR gate with the outputs of the flip-flops
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
