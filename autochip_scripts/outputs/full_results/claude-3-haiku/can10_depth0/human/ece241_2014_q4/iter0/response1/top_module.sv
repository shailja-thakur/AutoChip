module top_module (
    input clk,
    input x,
    output z
);

    // Declare three D flip-flops
    reg d1, d2, d3;

    // Connect the inputs to the three gates
    wire x_xor = x ^ d1;
    wire x_and = x & ~d2;
    wire x_or = x | ~d3;

    // Assign the D inputs of the flip-flops
    always @(posedge clk) begin
        d1 <= x_xor;
        d2 <= x_and;
        d3 <= x_or;
    end

    // Connect the flip-flop outputs to the XNOR gate
    assign z = ~(d1 ^ d2 ^ d3);

endmodule
