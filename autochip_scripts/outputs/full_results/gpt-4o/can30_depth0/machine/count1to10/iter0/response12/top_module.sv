module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Initial block to set the value of q to 1 at the start
    initial begin
        q = 4'b0001;
    end

    // Always block that triggers on the rising edge of the clock or the reset signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0001;  // If reset is active, set q to 1
        end
        else begin
            if (q == 4'b1010) begin
                q <= 4'b0001;  // When q reaches 10, reset it to 1
            end
            else begin
                q <= q + 1'b1;  // Otherwise, increment q by one
            end
        end
    end
endmodule
