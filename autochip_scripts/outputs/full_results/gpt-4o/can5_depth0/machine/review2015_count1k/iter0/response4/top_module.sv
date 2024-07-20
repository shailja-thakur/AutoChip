module top_module(
    input clk,
    input reset,
    output reg [9:0] q);
    
    // At every clock pulse
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is high, set q to 0
            q <= 10'b0;
        end else begin
            if (q == 10'd999) begin
                // If q reaches 999, reset it to 0
                q <= 10'b0;
            end else begin
                // Otherwise, increment q
                q <= q + 1;
            end
        end
    end

endmodule
