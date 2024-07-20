module top_module (
    input clk,
    input x,
    output z
);

    // Define internal D flip-flop outputs
    reg q1, q2, q3;
    
    // Define D flip-flop inputs
    wire d1, d2, d3;

    // XOR gate for the first D flip-flop
    assign d1 = x ^ q1;

    // AND gate for the second D flip-flop, using complemented output of the flip-flop
    assign d2 = x & ~q2;

    // OR gate for the third D flip-flop, using complemented output of the flip-flop
    assign d3 = x | ~(q3);

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // 3-input XNOR gate for the output
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
