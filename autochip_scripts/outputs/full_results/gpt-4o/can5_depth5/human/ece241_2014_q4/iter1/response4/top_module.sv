module top_module (
    input clk,
    input x,
    output reg z
);

    reg q1, q2, q3;

    // XOR gate with inputs x and q1
    wire xor_in = x ^ q1;
    // AND gate with inputs x and ~q2
    wire and_in = x & ~q2;
    // OR gate with inputs x and ~q3
    wire or_in = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_in;
        q2 <= and_in;
        q3 <= or_in;
    end

    // XNOR gate with inputs q1, q2, q3 for output z
    always @(*) begin
        z = ~(q1 ^ q2 ^ q3);
    end

endmodule
