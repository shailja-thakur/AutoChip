module top_module(
    input clk,
    input reset,
    output reg [2:0] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end
        else begin
            q <= q + 1;
            if (q[3:0] == 10)
                q[3:0] <= 0;
            if (q[7:4] == 10)
                q[7:4] <= 0;
            if (q[11:8] == 10)
                q[11:8] <= 0;
            if (q[15:12] == 10)
                q[15:12] <= 0;
            ena <= ena + 1'b1;
        end
    end

endmodule
