module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0; // Reset the counter to 0 on active high reset
        end else begin
            q <= (q == 4'd15) ? 0 : q + 1; // Increment the counter until it reaches 15, then reset to 0
        end
    end

endmodule
