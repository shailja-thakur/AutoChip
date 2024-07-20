module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            q <= (q == 10'b1111111111) ? 10'b0 : q + 1;
        end
    end

endmodule
