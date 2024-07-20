module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset output to 1
        end
        else if (q == 4'b1010) begin
            q <= 4'b0001; // Reset output to 1 when q reaches 10
        end
        else begin
            q <= q + 1; // Increment output by 1 if not reset
        end
    end

endmodule
