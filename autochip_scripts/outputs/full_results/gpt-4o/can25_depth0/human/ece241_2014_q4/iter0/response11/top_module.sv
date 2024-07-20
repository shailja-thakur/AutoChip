module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals for D flip-flops
    reg q1, q2, q3;
    
    // Internal signals for gates
    wire xor_out, and_out, or_out;
    
    // XOR gate: q1 = x ^ q1;
    assign xor_out = x ^ q1;

    // AND gate: q2 = x & ~q2;
    assign and_out = x & ~q2;

    // OR gate: q3 = x | ~q3;
    assign or_out = x | ~q3;
  
    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
