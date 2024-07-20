module top_module (
    input clk,
    input x,
    output z
);
    // Internal flip-flop signals
    reg q1, q2, q3;

    // Connections to the gates
    wire xor1, and1, or1;
    
    assign xor1 = x ^ q1;      // XOR gate
    assign and1 = x & ~q2;     // AND gate
    assign or1 = x | ~q3;      // OR gate

    // D flip-flop updates
    always @(posedge clk) begin
        q1 <= xor1;
        q2 <= and1;
        q3 <= or1;
    end

    // XNOR gate for final output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
