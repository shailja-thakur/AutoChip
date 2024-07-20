module top_module (
    input clk,
    input x,
    output z
);

    wire d1, d2, d3;
    wire q1, q2, q3;
    wire q1_n, q2_n, q3_n;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(d1), .q(q1), .q_n(q1_n));
    dff dff2 (.clk(clk), .d(d2), .q(q2), .q_n(q2_n));
    dff dff3 (.clk(clk), .d(d3), .q(q3), .q_n(q3_n));

    // Combinational Logic
    assign d1 = x ^ q1;
    assign d2 = x & q2_n;
    assign d3 = x | q3_n;

    // Output logic
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_n
);

    always @(posedge clk) begin
        q <= d;
        q_n <= ~d;
    end

endmodule
