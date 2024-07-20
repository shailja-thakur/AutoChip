module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        // Check if reset is asserted
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end
        else if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000;  // If counter equals 9, reset to 0
            end
            else begin
                q <= q + 1;  // Increment counter by 1
            end
        end
    end

endmodule
