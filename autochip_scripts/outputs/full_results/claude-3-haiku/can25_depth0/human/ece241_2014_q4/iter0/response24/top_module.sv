module top_module (
    input clk,
    input x,
    output z
);

    // Declare the D flip-flop registers
    reg d1, d2, d3;
    wire q1, q2, q3;

    // Implement the logic for the D flip-flops
    always @(posedge clk) begin
        d1 <= x;
        d2 <= x;
        d3 <= x;
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end

    // Implement the three gates and the XNOR
    wire xor_out, and_out, or_out;
    assign xor_out = x ^ q1;
    assign and_out = x & ~q2;
    assign or_out = x | ~q3;
    assign z = ~(xor_out ^ and_out ^ or_out);

endmodule
