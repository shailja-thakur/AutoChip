module top_module (
    input clk,
    input x,
    output z
);

    // Internal flip-flop outputs
    reg q1, q2, q3;

    // Next state logic for the flip-flops
    wire d1, d2, d3;

    // Connecting x and the respective outputs to the gates
    assign d1 = x ^ q1;  // XOR gate
    assign d2 = x & ~q2; // AND gate with complemented q2
    assign d3 = x | ~q3; // OR gate with complemented q3

    // Sequential logic for D flip-flops
    always @(posedge clk) begin
       q1 <= d1;
       q2 <= d2;
       q3 <= d3;
    end

    // Output logic for XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
