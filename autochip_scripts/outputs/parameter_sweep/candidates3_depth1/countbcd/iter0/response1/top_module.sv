module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            q <= 0;
        end 
        else begin
            q <= q + 1;
            if(q[3]) ena <= 3'b111;
            else ena <= 3'b000;
        end
    end

endmodule
