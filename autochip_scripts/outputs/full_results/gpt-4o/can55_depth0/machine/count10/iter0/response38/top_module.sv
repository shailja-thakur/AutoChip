module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the positive edge of the clk signal
    always @(posedge clk) begin
        // Check if reset is asserted
        if (reset) begin
            q <= 4'b0000; // Reset the counter to 0
        end else if (q == 4'b1001) begin
            q <= 4'b0000; // Reset the counter to 0 if q is 9
        end else begin
            q <= q + 1; // Increment the counter by 1
        end
    end
endmodule
