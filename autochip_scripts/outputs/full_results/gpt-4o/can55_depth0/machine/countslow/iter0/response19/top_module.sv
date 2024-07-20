module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0000; // Reset the counter to 0
        else if (slowena) begin
            if (q == 4'b1001) // Check if the counter is equal to 9
                q <= 4'b0000;  // Reset to 0 if it's equal to 9
            else
                q <= q + 1;   // Increment the counter if not equal to 9
        end
    end

endmodule
