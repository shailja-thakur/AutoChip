module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else if (ena[3])
            q <= q + 1;
        else begin
            q[3:0] <= q[3:0] + 1;
            if (q[3:0] == 10)
                q[3:0] <= 0;
            if (q[7:4] == 10)
                q[7:4] <= 0;
            if (q[11:8] == 10)
                q[11:8] <= 0;
        end
    end
endmodule
