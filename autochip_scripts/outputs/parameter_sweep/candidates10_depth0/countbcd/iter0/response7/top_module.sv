module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else begin
            q[3:0] <= q[3:0] + 1;
            if (q[3:0] == 10)
                q[3:0] <= 0;
            if (q[7:4] < 10 && ena[1])
                q[7:4] <= q[7:4] + 1;
            if (q[11:8] < 10 && ena[2])
                q[11:8] <= q[11:8] + 1;
            if (q[15:12] < 10 && ena[3])
                q[15:12] <= q[15:12] + 1;
        end
    end
    
endmodule
