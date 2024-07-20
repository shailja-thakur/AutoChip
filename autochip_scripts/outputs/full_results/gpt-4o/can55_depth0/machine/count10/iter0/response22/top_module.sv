module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block that is triggered on the positive edge of clk
    always @ (posedge clk) begin
        if (reset || q == 4'b1001)  // If reset is asserted or q equals 9
            q <= 4'b0000;          // Reset q to 0
        else
            q <= q + 1;            // Otherwise, increment q by 1
    end

endmodule
