module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock or asynchronously on reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is asserted, reset the counter to 0
            q <= 4'b0000;
        end else if (slowena) begin
            // If slowena is asserted, check the value of the counter
            if (q == 4'b1001) begin
                // If counter is equal to 9, reset the counter to 0
                q <= 4'b0000;
            end else begin
                // Otherwise, increment the counter by 1
                q <= q + 1;
            end
        end
    end

endmodule
