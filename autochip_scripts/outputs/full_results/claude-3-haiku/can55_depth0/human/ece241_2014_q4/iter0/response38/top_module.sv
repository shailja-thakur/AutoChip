module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    
    // XOR Gate
    wire xor_out;
    assign xor_out = x ^ q1;
    
    // AND Gate
    wire and_out;
    assign and_out = x & ~q2;
    
    // OR Gate
    wire or_out;
    assign or_out = x | ~q3;
    
    // D Flip-Flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end
    
    // XNOR Gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
