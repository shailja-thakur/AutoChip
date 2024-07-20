module top_module (
    input clk,
    input x,
    output z
);

    // Declare wires for flip-flop outputs and complemented outputs
    wire q1, q2, q3;
    wire nq1, nq2, nq3;

    // XOR gate input and output
    wire d1;
    assign d1 = x ^ q1;

    // AND gate input and output
    wire d2;
    assign d2 = x & nq2;

    // OR gate input and output
    wire d3;
    assign d3 = x | nq3;

    // D flip-flops
    d_ff dff1 (clk, d1, q1);
    d_ff dff2 (clk, d2, q2);
    d_ff dff3 (clk, d3, q3);

    // Complement outputs of the flip-flops
    assign nq1 = ~q1;
    assign nq2 = ~q2;
    assign nq3 = ~q3;

    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module d_ff (
    input clk,
    input d,
    output reg q 
);
    always @(posedge clk)
        q <= d;
endmodule
