module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd0; // Reset counter to 0
        end
        else if (q == 4'd9) begin
            q <= 4'd0; // Wrap around from 9 to 0
        end
        else begin
            q <= q + 1; // Increment counter
        end
    end

endmodule
