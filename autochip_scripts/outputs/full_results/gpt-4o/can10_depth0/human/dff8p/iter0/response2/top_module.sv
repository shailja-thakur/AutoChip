module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q);

    initial q = 8'h34; // Initial value for reset

    always @(negedge clk) begin
        if (reset)
            q <= 8'h34; // Reset value
        else
            q <= d;     // Update with new data
    end

endmodule
