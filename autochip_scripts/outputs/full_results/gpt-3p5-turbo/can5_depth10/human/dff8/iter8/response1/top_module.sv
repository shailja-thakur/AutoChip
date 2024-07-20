module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_tmp;

    always @(posedge clk)
        q_tmp <= d;

    always @(q_tmp)
        q <= q_tmp;

endmodule
