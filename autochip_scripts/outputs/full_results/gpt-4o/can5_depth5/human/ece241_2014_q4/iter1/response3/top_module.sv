module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    wire xor_out, and_out, or_out;

    // XOR gate with inputs x and q1
    assign xor_out = x ^ q1;
    // AND gate with inputs x and ~q2
    assign and_out = x & ~q2;
    // OR gate with inputs x and ~q3
    assign or_out = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate with inputs q1, q2, q3
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
