module top_module(
    input wire clk,
    input wire reset,
    output reg [3:1] ena,
    output reg [15:0] q);
    
    reg [15:0] q_next;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= q_next;
    end
    
    always @(posedge clk) begin
        if (reset)
            q_next <= 0;
        else begin
            if (ena[1])
                q_next[3:0] <= (q[3:0] == 4'b1001) ? 4'b0000 : q[3:0] + 1;
            if (ena[2])
                q_next[7:4] <= (q[7:4] == 4'b1001) ? 4'b0000 : q[7:4] + 1;
            if (ena[3])
                q_next[11:8] <= (q[11:8] == 4'b1001) ? 4'b0000 : q[11:8] + 1;
            end
    end
    
    assign ena[1] = (q[3:0] == 4'b1001);
    assign ena[2] = (q[7:4] == 4'b1001);
    assign ena[3] = (q[11:8] == 4'b1001);
    
endmodule
