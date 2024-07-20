module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3; // Flip-flop outputs
    wire q1_bar, q2_bar, q3_bar; // Complemented flip-flop outputs
    
    // Flip-flop inputs
    wire d1, d2, d3;
    
    // Actual D flip-flops
    dff dff1 (.clk(clk), .d(d1), .q(q1));
    dff dff2 (.clk(clk), .d(d2), .q(q2));
    dff dff3 (.clk(clk), .d(d3), .q(q3));
    
    // Complemented flip-flop outputs
    assign q1_bar = ~q1;
    assign q2_bar = ~q2;
    assign q3_bar = ~q3;
    
    // Gates
    assign d1 = x ^ q1; // XOR gate
    assign d2 = x & q2_bar; // AND gate
    assign d3 = x | q3_bar; // OR gate
    
    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
