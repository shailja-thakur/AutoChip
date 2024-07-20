module top_module (
    input clk,
    input x,
    output z
);
    wire q1, q2, q3;
    wire d1, d2, d3;
    
    // Intermediate complemented outputs of flip-flops
    wire q1_n, q2_n, q3_n;

    // Define the D flip-flops and their connections
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign q3_n = ~q3;
    
    // XOR gate, AND gate, OR gate
    assign d1 = x ^ q1;
    assign d2 = x & q2_n;
    assign d3 = x | q3_n;

    // XNOR gate to produce the output z
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
