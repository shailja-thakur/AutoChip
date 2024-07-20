module top_module(
    input clk, 
    input reset, 
    output [3:1] ena, 
    output reg [15:0] q);
         
    reg [3:0] q0, q1, q2, q3;
    reg [3:0] next_q0, next_q1, next_q2, next_q3;
                 
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= next_q0 + (next_q1 << 4) + (next_q2 << 8) + (next_q3 << 12);
    end

    always @(q0, q1, q2, q3, ena) begin
        next_q0 = q0;
        next_q1 = q1;
        next_q2 = q2;
        next_q3 = q3;

        if (ena[1])
            next_q1 = q1 + 1;
        if (ena[2])
            next_q2 = q2 + 1;
        if (ena[3])
            next_q3 = q3 + 1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q0 <= 0;
            q1 <= 0;
            q2 <= 0;
            q3 <= 0;
        end else begin
            q0 <= next_q0;
            q1 <= next_q1;
            q2 <= next_q2;
            q3 <= next_q3;
        end
    end
endmodule
