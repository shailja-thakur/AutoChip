module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 10'b0;  // Reset to 0 when reset is high
        else if (q == 10'd999)
            q <= 10'b0;  // Reset to 0 when reaching 999
        else
            q <= q + 1;  // Increment the counter
    end
endmodule
