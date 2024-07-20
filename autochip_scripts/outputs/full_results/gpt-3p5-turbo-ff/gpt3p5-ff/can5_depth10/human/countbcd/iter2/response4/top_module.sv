module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena[1]) begin
                q[4:0] <= (q[4:0] < 9) ? q[4:0] + 1 : 5'b00000;
                if (q[4:0] == 5'b00010) begin
                    q[8:4] <= (q[8:4] < 9) ? q[8:4] + 1 : 5'b00000;
                    if (q[8:4] == 5'b01010) begin
                        q[12:8] <= (q[12:8] < 9) ? q[12:8] + 1 : 5'b00000;
                    end
                end
            end
        end
    end
endmodule
