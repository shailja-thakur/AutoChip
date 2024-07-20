module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    integer i;

    always @(posedge clk)
        for (i = 0; i < 8; i = i + 1)
           q[i] <= d[i];

endmodule
