module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else if (slowena) begin
            if (q == 4'd9) begin
                q <= 4'b0000; // Reset counter to 0 if it reaches 9
            end else begin
                q <= q + 4'b0001; // Increment counter by 1
            end
        end
        // If slowena is not asserted, the counter does not increment.
    end

endmodule
