module top_module (
    input clk,
    input x,
    output z
);

    reg q1, q2, q3;

    // D flip-flops with resets
    always @(posedge clk) begin
        q1 <= x ^ q1; // XOR gate
        q2 <= x & ~q2; // AND gate
        q3 <= x | ~q3; // OR gate
    end

    // XNOR gates and final output z
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
