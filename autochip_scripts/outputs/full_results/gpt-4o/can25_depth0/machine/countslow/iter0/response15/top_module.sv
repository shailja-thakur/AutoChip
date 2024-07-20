module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock or asynchronously by reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Asynchronous reset resets the counter to 0
            q <= 4'b0000;
        end else if (slowena) begin
            // Counter increments only if slowena is asserted
            if (q == 4'b1001) begin
                // Reset counter to 0 if it reaches 9 (1001 in binary)
                q <= 4'b0000;
            end else begin
                // Otherwise, increment the counter by 1
                q <= q + 1;
            end
        end
    end
    
endmodule
