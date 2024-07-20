module top_module (
    input clk,
    input x,
    output z
);

    wire q1, q2, q3;
    wire not_q1, not_q2, not_q3;

    // D Flip-Flops
    dff dff1 (.clk(clk), .d(q1 ^ x), .q(q1), .q_n(not_q1));
    dff dff2 (.clk(clk), .d(q2 & ~x), .q(q2), .q_n(not_q2));
    dff dff3 (.clk(clk), .d(q3 | x), .q(q3), .q_n(not_q3));

    // Output Logic
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
