module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0000;
            ena <= 3'b000;
        end
        else begin
            if (ena[3])
                q <= q + 4'b0001;
            if (ena[2])
                q <= q + 4'b0010;
            if (ena[1])
                q <= q + 4'b0100;
        end
    end
endmodule
