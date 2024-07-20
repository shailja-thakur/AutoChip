module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0001; // Reset the counter to 1
        else if (q == 4'b1010)
            q <= 4'b0001; // Reset the counter to 1 after it reaches 10 (1010 in binary)
        else
            q <= q + 4'b0001; // Increment the counter
    end

endmodule
