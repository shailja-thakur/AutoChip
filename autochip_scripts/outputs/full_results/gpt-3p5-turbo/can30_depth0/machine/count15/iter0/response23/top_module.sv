module top_module(
    input wire clk,
    input wire reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q <= q + 1;
        end
    end

endmodule
