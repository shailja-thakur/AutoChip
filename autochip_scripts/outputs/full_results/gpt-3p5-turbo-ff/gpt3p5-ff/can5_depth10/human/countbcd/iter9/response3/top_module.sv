module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
    reg [15:0] next_q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (ena[1]) begin
                next_q[3:0] <= q[3:0] + 1;
            end else begin
                next_q[3:0] <= q[3:0];
            end

            if (ena[2]) begin
                next_q[7:4] <= q[7:4] + 1;
            end else begin
                next_q[7:4] <= q[7:4];
            end

            if (ena[3]) begin
                next_q[11:8] <= q[11:8] + 1;
            end else begin
                next_q[11:8] <= q[11:8];
            end

            next_q[15:12] <= q[15:12];
            q <= next_q;
        end
    end

    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = (q[7:4] == 9);
    assign ena[3] = (q[11:8] == 9);

endmodule
