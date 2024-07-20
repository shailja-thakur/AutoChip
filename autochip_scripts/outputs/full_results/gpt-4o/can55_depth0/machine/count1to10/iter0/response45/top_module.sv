module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

    // Sequential logic triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            // If reset is active, set q to 1
            q <= 4'b0001;
        end else begin
            // If q reaches 10, reset q to 1
            if (q == 4'b1010) begin
                q <= 4'b0001;
            end else begin
                // Otherwise, increment q by 1
                q <= q + 1;
            end
        end
    end

endmodule
