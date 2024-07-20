module top_module (
    input clk,
    input x,
    output z
);

    // Intermediate wires for the D flip-flops
    wire d1, d2, d3;
    reg q1, q2, q3;
    
    // Input to D flip-flop
    assign d1 = x ^ q1;
    assign d2 = x & ~q2;
    assign d3 = x | ~q3;
    
    // D flip-flops with asynchronous reset to zero
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
    
    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
