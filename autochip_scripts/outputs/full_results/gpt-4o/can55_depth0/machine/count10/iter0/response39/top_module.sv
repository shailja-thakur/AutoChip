module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Initialize the counter
    initial begin
        q = 4'b0;
    end

    // Always block triggered on the positive edge of the clk signal
    always @(posedge clk) begin
        if (reset || q == 4'b1001) begin
            q <= 4'b0;  // Reset the counter to 0
        end else begin
            q <= q + 1;  // Increment the counter by 1
        end
    end

endmodule
