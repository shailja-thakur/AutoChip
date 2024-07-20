module top_module(
    input clk,
    input reset,
    output reg [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_next;

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
            ena <= 3'b0;
        end else begin
            if (ena[1]) begin
                if (q[7:4] == 4'b1001)
                    q_next[7:4] <= 4'b0000;
                else
                    q_next[7:4] <= q[7:4] + 1;
            end else begin
                q_next[7:4] <= q[7:4];
            end
            if (ena[2]) begin
                if (q[11:8] == 4'b1001)
                    q_next[11:8] <= 4'b0000;
                else
                    q_next[11:8] <= q[11:8] + 1;
            end else begin
                q_next[11:8] <= q[11:8];
            end
            if (ena[3]) begin
                if (q[15:12] == 4'b1001)
                    q_next[15:12] <= 4'b0000;
                else
                    q_next[15:12] <= q[15:12] + 1;
            end else begin
                q_next[15:12] <= q[15:12];
            end
            if (q[3:0] == 4'b1001)
                q_next[3:0] <= 4'b0000;
            else
                q_next[3:0] <= q[3:0] + 1;
        end
    end

    always @(posedge clk) begin
        q <= q_next;
    end

endmodule
