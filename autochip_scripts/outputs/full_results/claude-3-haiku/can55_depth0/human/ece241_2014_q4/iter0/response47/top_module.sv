module top_module (
    input clk,
    input x,
    output z
);

    reg a_ff, b_ff, c_ff;

    // XOR gate
    wire a_xor = x ^ a_ff;

    // AND gate
    wire a_and = x & ~a_ff;

    // OR gate
    wire a_or = x | ~a_ff;

    // D flip-flops
    always @(posedge clk) begin
        a_ff <= a_xor;
        b_ff <= a_and;
        c_ff <= a_or;
    end

    // XNOR gate
    assign z = ~(a_ff ^ b_ff ^ c_ff);

endmodule
