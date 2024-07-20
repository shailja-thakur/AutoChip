module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else begin
            if (ena[1] & ena[2] & ena[3])
                q <= q + 1;
            else if (ena[2] & ena[3])
                q[3:0] <= q[3:0] + 1;
            else if (ena[3])
                q[7:4] <= q[7:4] + 1;
        end
    end
    
endmodule
