module top_module (
    input clk,
    input x,
    output z
);

    // Internal signals to hold the states of the D flip-flops
    reg d1, d2, d3;
    wire d1_next, d2_next, d3_next;
    wire xored, anded, ored;
    wire d2_not, d3_not;

    always @(posedge clk) begin
        d1 <= d1_next;  // Update D flip-flop 1
        d2 <= d2_next;  // Update D flip-flop 2
        d3 <= d3_next;  // Update D flip-flop 3
    end

    // XOR gate
    assign d1_next = x ^ d1;

    // Complemented outputs from flip-flops
    assign d2_not = ~d2;
    assign d3_not = ~d3;

    // AND gate with second input as complemented d2
    assign d2_next = x & d2_not;
    
    // OR gate with second input as complemented d3
    assign d3_next = x | d3_not;

    // 3-input XNOR gate for the final output
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
