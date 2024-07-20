module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output to a default value of 8'h0
    initial
        q <= 8'h0;

    // Always block triggered on the rising edge of the clock input
    always @(posedge clk)
        q <= d;

endmodule
