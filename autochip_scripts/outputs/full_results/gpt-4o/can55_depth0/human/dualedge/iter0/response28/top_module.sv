module top_module(
    input clk,
    input d,
    output reg q);

    reg q_posedge, q_negedge;

    always @(posedge clk)
        q_posedge <= d;

    always @(negedge clk)
        q_negedge <= d;

    always @(posedge clk or negedge clk)
        q <= (clk == 1'b1) ? q_posedge : q_negedge;

endmodule
