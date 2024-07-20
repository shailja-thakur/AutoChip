module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock or asynchronous reset
    always @(posedge clk or posedge reset) begin
        // Check if reset signal is asserted
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end else if (slowena) begin
            // Check if slowena signal is asserted
            if (q == 4'd9) begin
                q <= 4'b0000;  // Reset counter to 0
            end else begin
                q <= q + 1;  // Increment counter by 1
            end
        end
    end
endmodule
