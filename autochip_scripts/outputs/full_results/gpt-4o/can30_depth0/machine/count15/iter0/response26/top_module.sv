module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered at the rising edge of the clock signal
    always @(posedge clk) begin
        if (reset) begin
            // If reset is asserted, set the counter to 0
            q <= 4'b0000;
        end else begin
            // Otherwise, increment the counter by 1
            q <= q + 1;
        end
    end

endmodule
