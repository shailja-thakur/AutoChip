module top_module(
    input clk,
    input d,
    output reg q);

    reg d_pos, d_neg;

    always @(posedge clk)
        d_pos <= d;

    always @(negedge clk)
        d_neg <= d;

    always @(posedge clk or negedge clk)
        q <= clk ? d_pos : d_neg;

endmodule
