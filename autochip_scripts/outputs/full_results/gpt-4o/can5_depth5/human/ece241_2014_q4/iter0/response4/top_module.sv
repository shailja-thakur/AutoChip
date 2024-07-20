module top_module (
    input clk,
    input x,
    output z
);
    // Internal wires
    wire q1, q2, q3;
    wire dq1, dq2, dq3;
    wire xor_out, and_out, or_out;
    
    // XOR gate with D flip-flop output
    assign xor_out = x ^ q1;
    
    // AND gate with D flip-flop complement output
    assign and_out = x & ~q2;
    
    // OR gate with D flip-flop complement output
    assign or_out = x | ~q3;
    
    // D flip-flops
    dff dff1 (.clk(clk), .d(xor_out), .q(q1));
    dff dff2 (.clk(clk), .d(and_out), .q(q2));
    dff dff3 (.clk(clk), .d(or_out), .q(q3));
    
    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
module dff (
    input clk,
    input d,
    output reg q
);
    // D flip-flop with synchronous reset to zero
    always @(posedge clk) begin
        q <= d;
    end
endmodule
