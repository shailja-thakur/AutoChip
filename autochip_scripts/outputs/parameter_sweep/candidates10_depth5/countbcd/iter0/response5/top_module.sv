module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    reg [3:0] q0, q1, q2, q3;
    reg [3:0] q0_next, q1_next, q2_next, q3_next;

    // Next-state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q0_next <= 4'b0000;
            q1_next <= 4'b0000;
            q2_next <= 4'b0000;
            q3_next <= 4'b0000;
        end else begin
            q0_next <= (ena[0]) ? q0 + 1 : q0;
            q1_next <= (ena[1]) ? q1 + 1 : q1;
            q2_next <= (ena[2]) ? q2 + 1 : q2;
            q3_next <= q3 + 1;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            q <= 16'b0000000000000000;
        end else begin
            q[3:0] <= q0_next;
            q[7:4] <= q1_next;
            q[11:8] <= q2_next;
            q[15:12] <= q3_next;
        end
    end

    assign ena = {q[15], q[14], q[13]};
endmodule
