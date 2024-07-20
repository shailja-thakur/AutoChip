module top_module(
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q);

    always @(posedge clk or d)
        q <= d;

endmodule
