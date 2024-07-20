module top_module (
    input clk,
    input x,
    output z
);
    // D flip-flops
    reg q1, q2, q3;
    
    // Combinational logic for D flip-flop inputs
    wire d1 = x ^ q1;
    wire d2 = x & ~q2;
    wire d3 = x | ~q3;
    
    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
    
    // XNOR of the three D flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
