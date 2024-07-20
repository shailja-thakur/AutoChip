module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        // Check reset signal (asynchronous reset)
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end
        else if (slowena) begin
            // Check if counter is equal to 9
            if (q == 4'b1001) begin
                q <= 4'b0000; // Reset counter to 0
            end
            else begin
                q <= q + 1; // Increment the counter by 1
            end
        end
        // If slowena is not asserted, the counter does not change
    end

endmodule
