module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena[1]) begin
                q <= q + 1;
            end
            if (ena[2]) begin
                q <= q + 10;
            end
            if (ena[3]) begin
                q <= q + 100;
            end
        end
    end

endmodule
