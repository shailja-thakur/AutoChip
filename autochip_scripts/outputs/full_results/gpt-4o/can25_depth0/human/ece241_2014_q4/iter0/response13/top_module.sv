module top_module (
    input clk,
    input x,
    output z
);
    // Declare wire for each D flip-flop outputs
    wire q1, q2, q3;
    
    // XOR gate and D flip-flop
    wire d1 = x ^ q1;
    d_flipflop dff1 (
        .clk(clk),
        .d(d1),
        .q(q1)
    );
    
    // AND gate and D flip-flop
    wire d2 = x & ~q2;
    d_flipflop dff2 (
        .clk(clk),
        .d(d2),
        .q(q2)
    );
    
    // OR gate and D flip-flop
    wire d3 = x | ~q3;
    d_flipflop dff3 (
        .clk(clk),
        .d(d3),
        .q(q3)
    );
    
    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3); // XNOR can be derived using XOR and negation.

endmodule
module d_flipflop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
