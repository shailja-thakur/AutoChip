module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'h34;  // Reset value
        end else begin
            q <= d;  // Store data from d
        end
    end

endmodule
