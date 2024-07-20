module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock or the reset signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is asserted, reset the counter to 0
            q <= 4'b0000;
        end else if (slowena) begin
            // If slowena is asserted, check if the counter is 9
            if (q == 4'd9) begin
                q <= 4'b0000;  // If the counter is 9, reset it to 0
            end else begin
                q <= q + 1;  // Otherwise, increment the counter by 1
            end
        end
    end

endmodule
