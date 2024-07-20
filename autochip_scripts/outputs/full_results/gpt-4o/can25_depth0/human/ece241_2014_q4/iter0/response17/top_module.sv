module top_module (
    input clk,
    input x,
    output z
);
    // Internal signals
    reg q1, q2, q3;
    
    // Define the logic for each D flip-flop
    wire d1, d2, d3;
    
    assign d1 = x ^ q1;       // XOR gate
    assign d2 = x & ~q2;      // AND gate with complementary output of q2
    assign d3 = x | ~q3;      // OR gate with complementary output of q3
    
    // D flip-flops with asynchronous reset (init to zero)
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
    
    // Three-input XNOR gate to produce the output z
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
