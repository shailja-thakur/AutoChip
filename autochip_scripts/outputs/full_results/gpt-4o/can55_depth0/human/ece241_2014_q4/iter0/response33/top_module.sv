module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3; // Flip-flops

    // D flip-flop logic with asynchronous reset
    always @(posedge clk) begin
        q1 <= x ^ q1; // XOR with the previous output of q1
        q2 <= x & ~q2; // AND with the negation of the previous output of q2
        q3 <= x | ~q3; // OR with the negation of the previous output of q3
    end

    // 3-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);
    
endmodule
