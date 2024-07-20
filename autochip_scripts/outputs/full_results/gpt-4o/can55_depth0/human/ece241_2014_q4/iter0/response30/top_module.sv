module top_module (
    input clk,
    input x,
    output z
);

    // Flip-flop declarations
    reg q1, q2, q3;

    // Combinational logic
    wire xor_in, and_in, or_in;
    wire xor_out, and_out, or_out;
    wire xn, an, on;

    // XOR gate
    assign xor_in = q1;
    assign xor_out = x ^ xor_in;

    // AND gate
    assign and_in = ~q2;
    assign and_out = x & and_in;

    // OR gate
    assign or_in = ~q3;
    assign or_out = x | or_in;

    // D Flip-Flops
    always @(posedge clk) begin
        q1 <= xor_out;
        q2 <= and_out;
        q3 <= or_out;
    end

    // XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
