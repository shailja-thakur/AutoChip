module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // Always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        // If reset is active, set q to 0
        if (reset) begin
            q <= 0;
        end
        // Otherwise, increment q or reset q to 0 if it reaches 999
        else begin
            if (q == 999) begin
                q <= 0;
            end
            else begin
                q <= q + 1;
            end
        end
    end
endmodule
