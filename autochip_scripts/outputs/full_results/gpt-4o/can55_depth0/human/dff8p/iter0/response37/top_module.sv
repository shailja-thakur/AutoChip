module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Reset value is 0x34 (i.e., 52 in decimal)
    always @(negedge clk) begin
        if (reset)
            q <= 8'h34;
        else
            q <= d;
    end
endmodule
