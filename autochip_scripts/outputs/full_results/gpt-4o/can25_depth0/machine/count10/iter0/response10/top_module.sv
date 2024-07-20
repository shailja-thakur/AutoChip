module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on positive edge of clock or reset signal
    always @(posedge clk or posedge reset) begin
        if (reset) // If reset is asserted
            q <= 4'b0000; // Reset q to 0
        else if (q == 4'b1001) // If q is equal to 9
            q <= 4'b0000; // Reset q to 0
        else // Otherwise
            q <= q + 1; // Increment q by 1
    end
endmodule
