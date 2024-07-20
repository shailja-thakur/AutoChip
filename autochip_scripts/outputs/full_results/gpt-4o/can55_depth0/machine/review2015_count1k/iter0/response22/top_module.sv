module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // Always block triggered on the positive edge of the clock or when reset is active
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'd0; // Reset the counter to 0
        end else begin
            if (q == 10'd999) begin
                q <= 10'd0; // Reset the count to 0 when 999 is reached
            end else begin
                q <= q + 10'd1; // Increment the counter
            end
        end
    end

endmodule
