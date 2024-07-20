module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_temp;

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end else begin
            q_temp <= q;

            if (ena[1]) begin
                q_temp[7:4] <= q_temp[7:4] + 1;
            end
            if (ena[2]) begin
                q_temp[11:8] <= q_temp[11:8] + 1;
            end
            if (ena[3]) begin
                q_temp[15:12] <= q_temp[15:12] + 1;
            end
            q_temp[3:0] <= q_temp[3:0] + 1;

            q <= q_temp;
        end
    end
endmodule
