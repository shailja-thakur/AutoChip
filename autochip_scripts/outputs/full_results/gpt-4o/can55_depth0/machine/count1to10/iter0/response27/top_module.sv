module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

    // Process triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            // When reset signal is active, set q to 1
            q <= 4'b0001;
        end else begin
            // Otherwise, increment q by 1
            if (q == 4'b1010) begin
                // When q reaches 10, reset it to 1
                q <= 4'b0001;
            end else begin
                // Increment q
                q <= q + 4'b0001;
            end
        end
    end
endmodule
