module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;
    wire and_out, xor_out, or_out;

    // D Flip-Flops
    always @(posedge clk) begin
        q1 <= x;
        q2 <= x;
        q3 <= x;
    end

    // XOR Gate
    assign xor_out = x ^ q1;

    // AND Gate
    assign and_out = x & ~q2;

    // OR Gate
    assign or_out = x | ~q3;

    // XNOR Gate
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
