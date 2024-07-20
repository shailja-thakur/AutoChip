module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Initial reset value
    parameter RESET_VALUE = 8'h34;

    always @(negedge clk) begin
        if (reset) begin
            q <= RESET_VALUE;
        end else begin
            q <= d;
        end
    end

endmodule
