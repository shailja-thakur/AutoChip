module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_internal;

    always @(posedge clk)
        q_internal <= d;

    always @(posedge clk)
        q <= q_internal;

endmodule
