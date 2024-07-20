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
            q_next[3:0] <= (q_next[3:0] == 4'b1001) ? 4'b0000 : q_next[3:0] + 1;
            q_next[7:4] <= (ena[3]) ? ((q_next[3:0] == 4'b1001) ? 4'b0000 : q_next[7:4] + 1) : q_next[7:4];
            q_next[11:8] <= (ena[2]) ? ((q_next[7:4] == 4'b1001) ? 4'b0000 : q_next[11:8] + 1) : q_next[11:8];
            ena[1] <= (q_next[3:0] == 4'b1001);
            ena[2] <= (q_next[7:4] == 4'b1001);
            ena[3] <= (q_next[11:8] == 4'b1001);
        end
    end
    
endmodule
