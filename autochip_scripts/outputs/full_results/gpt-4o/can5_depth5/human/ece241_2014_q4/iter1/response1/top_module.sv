module top_module (
    input clk,
    input x,
    output reg z
);

    reg q1, q2, q3;

    wire xor_in, and_in, or_in;

    // XOR gate with inputs x and q1
    assign xor_in = x ^ q1;
    // AND gate with inputs x and ~q2
    assign and_in = x & ~q2;
    // OR gate with inputs x and ~q3
    assign or_in = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_in;
        q2 <= and_in;
        q3 <= or_in;
    end

    // XNOR gate with inputs q1, q2, q3
    always @(*) begin
        z = ~(q1 ^ q2 ^ q3);
    end

endmodule
