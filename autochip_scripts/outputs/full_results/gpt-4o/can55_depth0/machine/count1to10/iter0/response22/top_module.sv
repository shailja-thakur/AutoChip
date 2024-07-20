module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    initial q = 4'd1;  // Initializes the output register to 1 at the start

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            q <= 4'd1;  // Reset the output register to 1 when reset signal is active
        else if (q == 4'd10)
            q <= 4'd1;  // Reset the output register to 1 when the counter reaches 10
        else
            q <= q + 1;  // Increment the output register by 1
    end

endmodule
