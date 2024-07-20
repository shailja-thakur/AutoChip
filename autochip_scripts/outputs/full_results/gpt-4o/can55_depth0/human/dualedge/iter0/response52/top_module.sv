module top_module(
    input clk,
    input d,
    output reg q);

    reg q1, q2;

    always @(posedge clk)
        q1 <= d;

    always @(negedge clk)
        q2 <= d;

    always @(*)
        q <= clk ? q1 : q2;

endmodule
