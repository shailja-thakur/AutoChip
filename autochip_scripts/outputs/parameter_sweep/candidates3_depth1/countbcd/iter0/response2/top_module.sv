module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_next;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_next <= 0;
        end
        else begin
            q_next <= q + 1;
        end
    end

    always @* begin
        ena[1] = (q[3:0] >= 9);
        ena[2] = (q[7:4] >= 9);
        ena[3] = (q[11:8] >= 9);
        q = q_next;
    end

endmodule
