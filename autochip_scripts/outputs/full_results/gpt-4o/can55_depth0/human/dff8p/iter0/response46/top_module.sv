module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Initial value for reset
    parameter RESET_VALUE = 8'h34;

    always @(negedge clk) begin
        if (reset) 
            q <= RESET_VALUE;
        else 
            q <= d;
    end

endmodule
