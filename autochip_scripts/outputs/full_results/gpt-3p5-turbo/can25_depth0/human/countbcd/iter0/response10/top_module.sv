module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [15:0] q_next;

always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
        q <= 0;
    end else begin
        q <= q_next;
    end
end	  

always @* begin
    q_next = q;

    if (ena[1] == 1) begin
        if (q[3:0] == 9) begin
            q_next[3:0] = 0;
            q_next[7:4] = q[7:4] + 1;
        end else begin
            q_next[3:0] = q[3:0] + 1;
        end
    end

    if (ena[2] == 1) begin
        if (q[7:4] == 9) begin
            q_next[7:4] = 0;
            q_next[11:8] = q[11:8] + 1;
        end else begin
            q_next[7:4] = q[7:4] + 1;
        end
    end

    if (ena[3] == 1) begin
        if (q[11:8] == 9) begin
            q_next[11:8] = 0;
            q_next[15:12] = q[15:12] + 1;
        end else begin
            q_next[11:8] = q[11:8] + 1;
        end
    end
end

endmodule
