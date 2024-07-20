module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // Always triggered on the positive edge of the clock or when reset is asserted
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0;         // Reset the counter to 0
        end else begin
            if (q == 10'd999)   // When the counter reaches 999
                q <= 10'b0;     // Reset the counter to 0
            else
                q <= q + 1;     // Otherwise, increment the counter by 1
        end
    end
endmodule
