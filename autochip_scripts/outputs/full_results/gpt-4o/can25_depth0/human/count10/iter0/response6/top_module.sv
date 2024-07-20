module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd0; // Reset the counter to 0 when reset is high
        end else if (q == 4'd9) begin
            q <= 4'd0; // If the counter reaches 9, reset it to 0
        end else begin
            q <= q + 1; // Increment the counter
        end
    end
endmodule
