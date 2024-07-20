module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

localparam MAX_COUNT = 9999;

always @(posedge clk) begin
    if (reset) begin
        q <= 0;
    end
    else begin
        q[3:0] <= q[3:0] + 1;
        if (q[3:0] == 10) begin
            q[3:0] <= 0;
            q[7:4] <= q[7:4] + 1;
            ena[1] = 1;
        end
        else begin
            ena[1] = 0;
        end

        if (q[7:4] == 10) begin
            q[7:4] <= 0;
            q[11:8] <= q[11:8] + 1;
            ena[2] = 1;
        end
        else begin
            ena[2] = 0;
        end

        if (q[11:8] == 10) begin
            q[11:8] <= 0;
            q[15:12] <= q[15:12] + 1;
            ena[3] = 1;
        end
        else begin
            ena[3] = 0;
        end

        if (q == MAX_COUNT) begin
            q <= 0;
        end
    end
end

endmodule
