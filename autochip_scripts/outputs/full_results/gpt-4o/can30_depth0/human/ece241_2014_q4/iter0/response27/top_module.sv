module top_module (
    input clk,
    input x,
    output z
);

    // Define internal wires to connect the gates and D flip-flops
    wire q1, q2, q3;
    wire xor_out, and_out, or_out;
    wire xn1, xn2, xn3;

    // XOR gate input
    assign xor_out = x ^ q1;

    // AND gate input
    assign and_out = x & ~q2;

    // OR gate input
    assign or_out = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
