module top_module (
    input clk,
    input x,
    output z
);

    // Declare wires for the flip-flop outputs
    wire q1, q2, q3;

    // XOR gate
    wire xor_input;
    assign xor_input = x ^ q1;

    // AND gate
    wire and_input;
    assign and_input = x & ~q2;

    // OR gate
    wire or_input;
    assign or_input = x | ~q3;

    // D flip-flops
    always @(posedge clk) begin
        q1 <= xor_input;
        q2 <= and_input;
        q3 <= or_input;
    end

    // XNOR of the flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
