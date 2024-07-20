module top_module(
    input clk,
    input reset,
    output reg[2:0] ena,
    output reg[15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            ena <= 0;
        end
        else begin
            if (ena[0] && (q[3:0] == 9'd9))
                q[3:0] <= 0;
            else if (ena[0])
                q[3:0] <= q[3:0] + 1;
            
            if (ena[1] && (q[7:4] == 9'd9))
                q[7:4] <= 0;
            else if (ena[1])
                q[7:4] <= q[7:4] + 1;
            
            if (ena[2] && (q[11:8] == 9'd9))
                q[11:8] <= 0;
            else if (ena[2])
                q[11:8] <= q[11:8] + 1;
            
            if (q[15:12] == 9'd9)
                q[15:12] <= 0;
            else
                q[15:12] <= q[15:12] + 1;
        end
    end

endmodule
