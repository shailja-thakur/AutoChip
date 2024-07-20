module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire d1, d2, d3;

    // Initialize flip-flops to zero
    initial begin
        q1 = 0;
        q2 = 0;
        q3 = 0;
    end
    
    // D flip-flop logic with different gates
    assign d1 = x ^ q1;          // XOR gate
    assign d2 = x & ~q2;         // AND gate with complemented output
    assign d3 = x | ~q3;         // OR gate with complemented output
    
    // D flip-flop instantiation
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
    
    // Three input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
