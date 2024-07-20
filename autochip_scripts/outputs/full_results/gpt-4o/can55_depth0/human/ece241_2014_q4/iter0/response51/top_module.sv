module top_module (
    input clk,
    input x,
    output z
);
    reg q1, q2, q3; // Outputs of D flip-flops
    wire d1, d2, d3; // Inputs to D flip-flops
    wire xnor_in1, xnor_in2, xnor_in3; // Outputs of individual gates

    // D flip-flop assignments
    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // XOR gate: q1(d1) = x XOR q1
    assign d1 = x ^ q1;
    // AND gate: q2(d2) = x AND ~q2
    assign d2 = x & ~q2;
    // OR gate: q3(d3) = x OR ~q3
    assign d3 = x | ~q3;

    // XNOR gate
    assign xnor_in1 = d1;
    assign xnor_in2 = d2;
    assign xnor_in3 = d3;
    assign z = ~(xnor_in1 ^ xnor_in2 ^ xnor_in3);

endmodule
