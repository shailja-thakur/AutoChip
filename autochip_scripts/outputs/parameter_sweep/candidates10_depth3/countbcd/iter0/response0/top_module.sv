module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk) begin
        if(reset)
            q <= 0;
        else begin
            if(ena[3])
                q <= q + 1;
            if(ena[2])
                q[7:4] <= q[7:4] + 1;
            if(ena[1])
                q[11:8] <= q[11:8] + 1;
            if(ena[0])
                q[15:12] <= q[15:12] + 1;
        end
    end

endmodule
