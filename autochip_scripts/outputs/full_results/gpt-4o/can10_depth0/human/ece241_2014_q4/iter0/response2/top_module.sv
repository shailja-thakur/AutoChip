module top_module (
    input clk,
    input x,
    output z
);
    
    wire d0, d1, d2;
    wire q0, q1, q2;
    wire q0_n, q1_n, q2_n;
    wire xnor_out;

    // Flip-Flop 0
    assign d0 = x ^ q0;
    d_flip_flop ff0 (
        .clk(clk),
        .d(d0),
        .q(q0)
    );

    // Flip-Flop 1
    assign d1 = x & q1_n;
    d_flip_flop ff1 (
        .clk(clk),
        .d(d1),
        .q(q1)
    );

    // Flip-Flop 2
    assign d2 = x | q2_n;
    d_flip_flop ff2 (
        .clk(clk),
        .d(d2),
        .q(q2)
    );

    // Apply the xnor gate
    assign q0_n = ~q0;
    assign q1_n = ~q1;
    assign q2_n = ~q2;
    assign xnor_out = ~(q0 ^ q1 ^ q2);
    assign z = xnor_out;

endmodule
module d_flip_flop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
