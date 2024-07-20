module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  // Reset counter to 0
        end else begin
            if (q == 4'b1001) begin
                q <= 4'b0000;  // Reset counter to 0 after it reaches 9
            end else begin
                q <= q + 4'b0001;  // Increment counter
            end
        end
    end

endmodule
