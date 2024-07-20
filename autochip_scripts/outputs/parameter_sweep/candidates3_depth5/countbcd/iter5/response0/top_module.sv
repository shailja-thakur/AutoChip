module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else if (ena[1])
            q[3:0] <= (q[3:0] == 4'b1001) ? 4'b0000 : q[3:0] + 1;
            
        if (reset)
            q[7:4] <= 0;
        else if (ena[2])
            q[7:4] <= (q[7:4] == 4'b1001) ? 4'b0000 : q[7:4] + 1;
            
        if (reset)
            q[11:8] <= 0;
        else if (ena[3])
            q[11:8] <= (q[11:8] == 4'b1001) ? 4'b0000 : q[11:8] + 1;
    end
    
    assign ena[1] = (q[3:0] == 4'b1001);
    assign ena[2] = (q[7:4] == 4'b1001);
    assign ena[3] = (q[11:8] == 4'b1001);
    
endmodule
