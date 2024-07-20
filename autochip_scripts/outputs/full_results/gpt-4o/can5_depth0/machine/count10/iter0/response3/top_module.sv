module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the positive edge of the clk
    always @(posedge clk) begin
        // If reset is asserted or current value of q is equal to 9
        if (reset || q == 4'd9) begin
            q <= 4'b0000;  // Reset q to 0
        end else begin
            q <= q + 1;  // Increment q by 1
        end
    end
endmodule
