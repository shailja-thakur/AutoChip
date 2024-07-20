module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_next;

    always @(posedge clk)
        q <= q_next;

    always @(d)
        q_next <= d;

endmodule
