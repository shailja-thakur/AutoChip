module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0001;  // Set output register to 1 when reset is active
        else if (q == 4'b1010)
            q <= 4'b0001;  // Reset to 1 when q reaches 10
        else
            q <= q + 1;    // Increment output register by one
    end
endmodule
