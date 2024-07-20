module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    // Reset value is 0x34
    parameter RESET_VALUE = 8'h34;

    always @(negedge clk) begin
        if (reset) begin
            q <= RESET_VALUE;  // Reset to 0x34
        end else begin
            q <= d;  // Assign input d to q
        end
    end

endmodule
