module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0;
        end else if (q == 999) begin
            q <= 10'b0;
        end else begin
            q <= q + 1;
        end
    end
endmodule
