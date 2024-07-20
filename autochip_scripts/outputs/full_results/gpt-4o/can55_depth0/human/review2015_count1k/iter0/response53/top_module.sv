module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    // Synchronous reset implementation
    always @(posedge clk) begin
        if (reset) begin
            q <= 10'd0; // Reset counter to 0
        end
        else begin
            if (q == 10'd999) begin
                q <= 10'd0; // Reset counter when it reaches 999
            end
            else begin
                q <= q + 10'd1; // Increment counter
            end
        end
    end
endmodule
