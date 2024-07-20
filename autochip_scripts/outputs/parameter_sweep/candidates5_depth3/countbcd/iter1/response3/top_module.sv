module top_module(
    input wire clk,
    input wire reset,
    output wire [2:0] ena,
    output reg [15:0] q
);

    reg [3:0] q3;
    reg [3:0] q2;
    reg [3:0] q1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
            q3 <= 0;
            q2 <= 0;
            q1 <= 0;
            ena <= 0;
        end else begin
            if (ena[0] && q1 == 9) q1 <= 0;
            else if (ena[0]) q1 <= q1 + 1;

            if (ena[1] && q2 == 9) q2 <= 0;
            else if (ena[1]) q2 <= q2 + 1;

            if (ena[2] && q3 == 9) q3 <= 0;
            else if (ena[2]) q3 <= q3 + 1;

            q = {q3, q2, q1};
        end
    end
endmodule
