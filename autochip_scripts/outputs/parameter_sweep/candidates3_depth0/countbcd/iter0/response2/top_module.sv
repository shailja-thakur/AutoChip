module top_module(
    input clk,
    input reset,
    output [0:2] ena,
    output reg [15:0] q);

    reg [3:0] q0, q1, q2, q3;
    reg [2:0] ena0, ena1, ena2;
  
    always @(posedge clk or posedge reset) begin
        if (reset)
            begin
                q0 <= 0;
                q1 <= 0;
                q2 <= 0;
                q3 <= 0;
                ena0 <= 0;
                ena1 <= 0;
                ena2 <= 0;
            end
        else begin
            q0 <= q0 + 1;
            if (q0 == 10) begin
                q0 <= 0;
                ena0 <= 1;
            end
            if (ena0)
                q1 <= q1 + 1;
            if (q1 == 10) begin
                q1 <= 0;
                ena0 <= 0;
                ena1 <= 1;
            end
            if (ena1)
                q2 <= q2 + 1;
            if (q2 == 10) begin
                q2 <= 0;
                ena1 <= 0;
                ena2 <= 1;
            end
            if (ena2)
                q3 <= q3 + 1;
            if (q3 == 10) begin
                q3 <= 0;
                ena2 <= 0;
            end
        end
    end

    assign ena = {ena2, ena1, ena0};
    assign q = {q3, q2, q1, q0};

endmodule
