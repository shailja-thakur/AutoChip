module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        q[3:0] <= q[3:0] + 1;
        if (q[3:0] == 4'b1010) begin
            q[3:0] <= 4'b0000;
            ena[1] = 1'b1;
        end
        else begin
            ena[1] = 1'b0;
        end

        if (q[7:4] == 4'b1010) begin
            q[7:4] <= 4'b0000;
            ena[2] = 1'b1;
        end
        else begin
            ena[2] = 1'b0;
        end

        if (q[11:8] == 4'b1001) begin
            q[11:8] <= 4'b0000;
            ena[3] = 1'b1;
        end
        else begin
            ena[3] = 1'b0;
        end

        q[15:12] <= q[15:12] + ena[3];
    end
end

endmodule
