module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block that triggers on rising edge of clock or asynchronous reset
    always @(posedge clk or posedge reset) begin
        // Check for asynchronous reset
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end
        else if (slowena) begin
            if (q == 4'd9) begin
                q <= 4'b0000;  // Reset counter to 0 when it reaches 9
            end
            else begin
                q <= q + 1;  // Increment counter by 1
            end
        end
    end
endmodule
