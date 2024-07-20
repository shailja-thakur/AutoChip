module top_module (
    input clk,
    input x,
    output z
);

    // Internal wires for flip-flop outputs
    wire q1, q2, q3;

    // D flip-flops with asynchronous reset
    reg d1, d2, d3;
    always @(posedge clk) begin
        d1 <= x ^ q1;         // XOR gate
        d2 <= x & ~q2;        // AND gate
        d3 <= x | ~q3;        // OR gate
    end

    // Instantiate flip-flops
    dff ff1 (.clk(clk), .d(d1), .q(q1));
    dff ff2 (.clk(clk), .d(d2), .q(q2));
    dff ff3 (.clk(clk), .d(d3), .q(q3));

    // XNOR of all flip-flop outputs
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
